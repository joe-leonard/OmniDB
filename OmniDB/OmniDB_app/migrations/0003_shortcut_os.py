# Generated by Django 3.0.8 on 2020-10-03 17:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('OmniDB_app', '0002_consolehistory_start_time'),
    ]

    operations = [
        migrations.AddField(
            model_name='shortcut',
            name='os',
            field=models.CharField(default='', max_length=200),
            preserve_default=False,
        ),
    ]
