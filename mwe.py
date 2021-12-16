from pyexcel import iget_records


input('Press Enter to start')

with open('/big_csv.csv') as file:
    sheet = iget_records(file_type='csv', file_stream=file, delimiter=',', quotechar='"')

    for lineno, line in enumerate(sheet, 1):
        if lineno % 10000 == 0:
            print(f'Read {lineno:,d} lines')

input('Press Enter to exit')
