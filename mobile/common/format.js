export function money(value, digits = 2) {
  const number = Number(value || 0)
  return number.toLocaleString('zh-CN', {
    minimumFractionDigits: digits,
    maximumFractionDigits: digits
  })
}

export function compactMoney(value) {
  const number = Number(value || 0)
  const abs = Math.abs(number)
  if (abs >= 100000000) return (number / 100000000).toFixed(2) + ' 亿'
  if (abs >= 10000) return (number / 10000).toFixed(1) + ' 万'
  return money(number, 0)
}

export function percent(value) {
  return Number(value || 0).toFixed(2) + '%'
}

export function periodText(period) {
  if (!period || period.length < 6) return period || '--'
  return period.slice(0, 4) + '年' + period.slice(4, 6) + '月'
}

export function statusText(status) {
  return status === 'good' ? '稳健' : status === 'watch' ? '关注' : '预警'
}
