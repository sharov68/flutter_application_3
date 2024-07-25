import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/all_tasks.dart';
import 'package:flutter_application_3/screens/profile.dart';
import 'package:flutter_application_3/theme/theme.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    TasksPage(),
    Text('Сегодня'),
    ProfilePage(),
    Text('Выполнено'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Функция для открытия диалогового окна
  void _showAddTaskDialog() {
    // Инициализация переменной для хранения выбранной даты и времени
    DateTime? _selectedDateTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Добавить задачу'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Название задачи',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Описание задачи',
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Кнопка для выбора даты и времени
                  ElevatedButton(
                    onPressed: () {
                      // Открытие диалогового окна выбора даты и времени
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      ).then((pickedDate) {
                        if (pickedDate == null) return;
                        // Открытие диалогового окна выбора времени
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((pickedTime) {
                          if (pickedTime == null) return;
                          // Создание объекта DateTime из выбранной даты и времени
                          _selectedDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          // Обновление состояния
                          setState(() {});
                        });
                      });
                    },
                    child: _selectedDateTime != null
                        ? Text(
                            '${DateFormat('dd.MM.yyyy HH:mm').format(_selectedDateTime!)}',
                          )
                        : const Text('Выбрать дедлайн'),
                  ),
                  // Отображение выбранной даты и времени
                  // if (_selectedDateTime != null)
                  //   Text(
                  //     'Выбранный дедлайн: ${DateFormat('dd.MM.yyyy HH:mm').format(_selectedDateTime!)}',
                  //   ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена'),
                ),
                TextButton(
                  onPressed: () {
                    // Обработка ввода данных из полей
                    // ...
                    Navigator.of(context).pop();
                  },
                  child: const Text('Добавить'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              DoDidDoneTheme.lightTheme.colorScheme.secondary,
              DoDidDoneTheme.lightTheme.colorScheme.primary,
            ],
            stops: const [0.1, 0.9], // Primary occupies 90%
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Задачи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Сегодня',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Выполнено',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
