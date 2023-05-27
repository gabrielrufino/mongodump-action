# Mongodump Action

GitHub Action for creating a binary export of a database's contents

## Example usage

```yml
name: Backup

on:
  schedule:
    - cron: 0 0 * * *

jobs:
  backup:
    runs-on: ubuntu-latest
    steps:
      - uses: gabrielrufino/mongodump-action
        with:
          connection-string: ${{ secrets.MONGO_URI }}
      - uses: actions/upload-artifact@v3
        with:
          name: dump
          path: ${{ github.workspace }}/dump
```

## Security

Remember that artifacts can be downloaded by anyone who has the artifact download link or access to the workflow run. Which means that you need to use a private repository if you want create backups and upload them as artifacts.
