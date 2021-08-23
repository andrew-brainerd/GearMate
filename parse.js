require('dotenv').config();
const fs = require('fs');
const luaparse = require('luaparse');

console.log('');

try {
  const data = fs.readFileSync(process.env.FILE_PATH, 'utf8');
  const parsedData = luaparse.parse(data);
  const gearData = getGearData(parsedData);

  const gear = gearData.map(field => {
    if (field.value.fields) {
      return {
        itemId: getValue(field, 0),
        itemSlot: getValue(field, 1)
      };
    }

    return {};
  }).filter(item => item.itemId);

  console.log('Gear', gear);
} catch (err) {
  console.error(err);
}

function getGearData(data) {
  return data.body[0].init[0].fields[0].value.fields;
}

function getValue(field, index) {
  return field.value.fields[index].value.value;
}
