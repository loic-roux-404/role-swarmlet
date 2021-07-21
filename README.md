# Swarmlet

Install swarmlet PaaS platform

## Roadmap

- [x] Create deploy ssh keys
- [ ] Publish deploy key on git provider organisation or user
- [ ] Secure ip allowed with authorized key

## Install to requirements.yml

```
- src: git+git@github.com:loic-roux-404/role-swarmlet
  version: master
```

## Requirements

None

## Role Variables

- Check [defaults.yml](./defaults/main.yml)

## Dependencies

None

## Example Playbook

```yaml
- hosts: servers
  roles:
    - { role: role-swarmlet }
```

After running you will find the deploy key for your swarmlet cluster in a directory of your machine.
Should be in `/tmp/ansible` but can change depending on your remote server domain / IP.

## License

MIT

## Author Information

[Loic Roux](github.com/loic-roux-404)
