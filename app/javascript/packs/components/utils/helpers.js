function moneyFormat(valueInCents) {
  return `$ ${Number(valueInCents)/100}`
}

export { moneyFormat }