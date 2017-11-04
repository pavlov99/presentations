import json

from django.test import TestCase
from django.contrib.auth import get_user_model
from mixer.backend.django import mixer


class BaseTestCase(TestCase):

    """ Set up user and configure access to the system.

    Create user with email: user@example.com, password: password

    """

    def setUp(self):
        self.user = mixer.blend(
            get_user_model(), username='testuser', is_active=True
        )
        self.user.set_password('password')
        self.user.save()


class TestJsonrpc(BaseTestCase):

    """ Dummy tests for json-rpc initial/investigation integration."""

    def test_ping(self):
        json_data = {
            "id": 0, "jsonrpc": "2.0", "method": "ping",
        }
        response = self.client.post(
            '/api/v1/jsonrpc',
            json.dumps(json_data),
            content_type='application/json',
        )
        self.assertEqual(response.status_code, 200)
        json_response = json.loads(response.content.decode('utf8'))
        self.assertEqual(json_response['result'], 'pong')

    def test_echo(self):
        json_data = {
            "id": 0, "jsonrpc": "2.0", "method": "echo",
            "params": {"s": "hello"}
        }
        response = self.client.post(
            '/api/v1/jsonrpc',
            json.dumps(json_data),
            content_type='application/json',
            **auth_headers
        )
        self.assertEqual(response.status_code, 200)
        json_response = response.json()
        self.assertEqual(json_response['result'], 'hello')

    def test_request_non_existing_method(self):
        json_data = {
            "id": 0, "jsonrpc": "2.0", "method": "does_not_exist"
        }
        response = self.client.post(
            '/api/v1/jsonrpc',
            json.dumps(json_data),
            content_type='application/json'
        )
        self.assertEqual(response.status_code, 200)
        json_response = response.json()
        self.assertEquals(
            json_response['error'],
            {'code': -32601, 'message': 'Method not found'}
        )
