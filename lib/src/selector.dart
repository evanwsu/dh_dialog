///@author Evan
///@since 2020/12/23
///@describe: 

class Selector<T>{
  /// 通常状态
  final T normal;
  /// 选中状态
  final T active;
  /// 不可用状态
  final T disabled;
  /// 选中不可用状态
  final T inactive;

  /// 不同状态单独设置
  /// 未设置状态的图标为null
  const Selector.only({this.normal, this.active, this.disabled, this.inactive});

  /// value设置给所有状态
  const Selector.all(T value)
      : normal = value,
        active = value,
        disabled = value,
        inactive = value;

  /// active 设置[active] 状态
  /// 其余设置[normal] 状态
  /// 使用不考虑 选中不可用状态
  const Selector.normal({T normal, T active})
      : normal = normal,
        active = active,
        disabled = normal,
        inactive = normal;

  /// normal 设置[normal] 和 [disabled]
  /// active 设置[active] 和 [inactive]
  /// 效果同Selected.disabled, 参数名不同, 重在表达正常状态
  const Selector.active({T normal, T active})
      : normal = normal,
        active = active,
        disabled = normal,
        inactive = active;

  /// disabled 设置[normal] 和 [disabled]
  /// inactive 设置[active] 和 [inactive]
  /// 效果同Selected.active, 参数名不同, 重在表达选中状态
  const Selector.disabled({T disabled, T inactive})
      : normal = disabled,
        active = inactive,
        disabled = disabled,
        inactive = inactive;

  /// 获取对应状态值
  static T getSelected<T>(Selector<T> selected, [bool checked = false, bool disabled = false]) {
    if (selected == null) return null;

    T state;
    if (disabled && checked) {
      state = selected.inactive;
    } else if (disabled) {
      state = selected.disabled;
    } else if (checked) {
      state = selected.active;
    } else {
      state = selected.normal;
    }
    return state;
  }
}
