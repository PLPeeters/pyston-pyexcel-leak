This container creates a random CSV with ~3M lines and reads it using [`pyexcel.iget_records`](http://docs.pyexcel.org/en/latest/generated/pyexcel.iget_records.html) to illustrate a memory leak when using pyexcel with [Pyston](https://github.com/pyston/pyston).

## Steps to Reproduce

1. Run `./run-test.sh`
2. In a separate shell, run `docker stats`
3. Identify your container, then press Enter in the shell where you ran the script in (1) to start reading the CSV file
4. Monitor the Docker stats and see memory increasing linearly

To see it doesn't happen with the `python:3.8` image, edit the Dockerfile as needed and run through the same steps; memory usage will be constant.

## Observations

Memory used by container (Python 3.8):

1. Before starting: 32 MB
2. Before exiting: 33 MB

Memory used by container (Pyston):

1. Before starting: 39 MB
2. Before exiting: 723 MB

When changing the CSV delimiter to `;`, which reduces the number of fields per line from 3 to 1, memory before exiting is reduced to 300 MB, so this seems related to the number of fields (and not lines) pyexcel has to process.

In my quest to get the most minimal reproducible example I could, I tried to see if using `csv.reader` would reproduce this bug as well; it doesn't.
