## timezone-selector

Nice little command-line UI for selecting timezones in Unix systems.

![](https://cldup.com/EDsMvK-PUI.png)

## usage

```bash
source timezone-selector.sh
tzSelectionMenu "Optional background title"
```

It'll set the result to $selected;

```bash
echo "$selected"
# > /usr/share/zoneinfo/Chile/Continental
```

And you can set the timezone by:

```bash
ln -s $selected /etc/localtime
```
