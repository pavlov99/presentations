# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations
from django.contrib.auth import get_user_model
from django.utils import timezone

def add_admin(apps, schema_editor):
    db_alias = schema_editor.connection.alias
    get_user_model().objects.using(db_alias).create(
        username="admin", is_active=True, is_staff=True, is_superuser=True,
        last_login=timezone.now(),
        password="pbkdf2_sha256$12000$Tp14tFK8CLpx$qe3AiraPNsJ/h/L8AUOPuqIYcNg02lrpU/XP7cyU3A0="
    )

def del_admin(apps, schema_editor):
    db_alias = schema_editor.connection.alias
    get_user_model().objects.using(db_alias).get(username="admin").delete()


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0001_initial'),
    ]

    operations = [
        migrations.RunPython(add_admin, del_admin),
    ]
