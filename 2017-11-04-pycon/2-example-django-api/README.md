# Example of Django server with json rpc.

json-rpc supports Django backend (Django is not a dependency) and provides additional functionality, such as url map generation and raw request injection.

Request object injection is convenient for authentication check or if a method requires a meta information about the request. Such injection does not support parameters as list. Following example use dictionary for parameters.

1. Test integration. "ping" method.
```bash
curl -X POST -H "Content-Type: application/json" \
    --data '{"id": 0, "jsonrpc": "2.0", "method": "ping"}' \
    http://127.0.0.1:8000/api/v1/jsonrpc | python -mjson.tool

{
    "id": 0,
    "jsonrpc": "2.0",
    "result": "pong"
}

```
2. Echo method with parameters
```bash
curl -X POST -H "Content-Type: application/json" \
    --data '{"id": 1, "jsonrpc": "2.0", "method": "echo", "params": {"s": "PyCon 2017"}}' \
    http://127.0.0.1:8000/api/v1/jsonrpc | python -mjson.tool

{
    "id": 1,
    "jsonrpc": "2.0",
    "result": "PyCon 2017"
}
```
3. Example "Parse Error"
```bash
curl -X POST -H "Content-Type: application/json" \
    --data '{' \
    http://127.0.0.1:8000/api/v1/jsonrpc | python -mjson.tool

{
    "error": {
        "code": -32700,
        "message": "Parse error"
    },
    "id": null,
    "jsonrpc": "2.0"
}

```
4. Example "Invalid Params"
```bash
curl -X POST -H "Content-Type: application/json" \
    --data '{"id": 3, "jsonrpc": "2.0", "method": "echo"}' \
    http://127.0.0.1:8000/api/v1/jsonrpc | python -mjson.tool

{
    "error": {
        "code": -32602,
        "data": {
            "args": [
                "echo() takes exactly 2 arguments (1 given)"
            ],
            "message": "echo() takes exactly 2 arguments (1 given)",
            "type": "TypeError"
        },
        "message": "Invalid params"
    },
    "id": 3,
    "jsonrpc": "2.0"
}
```
5. Example: "Method not found"
```bash
curl -X POST -H "Content-Type: application/json" \
    --data '{"id": 4, "jsonrpc": "2.0", "method": "fake"}' \
    http://127.0.0.1:8000/api/v1/jsonrpc | python -mjson.tool

{
    "error": {
        "code": -32601,
        "message": "Method not found"
    },
    "id": 4,
    "jsonrpc": "2.0"
}
```
