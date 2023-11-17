find $@ \( -type f -execdir chmod 644 {} \; \) \
  -o \( -type d -execdir chmod 755 {} \; \)
