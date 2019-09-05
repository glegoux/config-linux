# TouchPad

Find touchpad:

```
device_name=$(xinput list --name-only | grep -i TouchPad)
device_id=$(xinput list --id-only "${device_name}")
echo "${device_name},${device_id}"
```

Disable touchpad:

```
xinput --list-props ${device_id}
```

Activate touchpad:

```
xinput --list-props ${device_id}
```

See properties touchpad:

```
xinput --list-props ${device_id}
```

*References*

