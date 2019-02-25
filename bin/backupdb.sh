#!/bin/bash
# Back up MySQL (MariaDB) database(s)
mysqldump -ulegnerjm -pmoocow01 legnereng | gzip > /media/family/Dropbox/legeng/it/data/backups/legnereng_backup$(date +%d).sql.gz

