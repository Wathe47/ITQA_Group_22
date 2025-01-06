const open = require('open');
const path = require('path');
const fs = require('fs');

const reportPath = path.join(__dirname, 'reports', 'cucumber-report.html');

const maxRetries = 10;
const retryInterval = 500; // 500ms

function checkFileExists(retryCount = 0) {
    if (retryCount >= maxRetries) {
        console.error('Error: Report file was not generated within the expected time.');
        process.exit(1);
    }

    fs.access(reportPath, fs.constants.F_OK, (err) => {
        if (err) {
            console.log(`Report file not ready yet, retrying in ${retryInterval}ms...`);
            setTimeout(() => checkFileExists(retryCount + 1), retryInterval);
            return;
        }

        open(reportPath)
            .then(() => {
                console.log('Report opened successfully!');
            })
            .catch((error) => {
                console.error('Error opening report:', error);
                process.exit(1);
            });
    });
}

checkFileExists();
