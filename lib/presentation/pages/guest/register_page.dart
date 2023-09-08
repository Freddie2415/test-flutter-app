import 'package:app/domain/entities/category.dart';
import 'package:app/presentation/blocs/categories/categories_cubit.dart';
import 'package:app/presentation/blocs/register/register_cubit.dart';
import 'package:app/presentation/pages/guest/login_page.dart';
import 'package:app/presentation/pages/guest/success_page.dart';
import 'package:app/presentation/widgets/input.dart';
import 'package:app/presentation/widgets/text_divider.dart';
import 'package:app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/validator.dart';
import '../../widgets/bottom_sheet_select.dart';
import '../../widgets/header_text.dart';
import '../../widgets/select_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

  static Route<Object?> route() => MaterialPageRoute(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<RegisterCubit>(
                create: (_) => locator.get<RegisterCubit>(),
              ),
              BlocProvider<CategoriesCubit>(
                create: (_) => locator.get<CategoriesCubit>(),
              ),
            ],
            child: const RegisterPage(),
          );
        },
      );
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _productController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Category> categories = [];

  Category? selectedCategory;

  @override
  void initState() {
    BlocProvider.of<CategoriesCubit>(context).load();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _productController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HeaderText(
                title: 'Подать заявку',
                subtitle: 'Войти в систему чтобы торговать в системе',
              ),
              const SizedBox(height: 20),
              Input(
                title: "Ф.И.О.",
                hint: 'Введите вашу Ф.И.О.',
                controller: _nameController,
                type: TextInputType.text,
                validator: Validator.required,
              ),
              const SizedBox(height: 16),
              Input(
                title: "Название продукта",
                hint: 'Введите название продукта',
                controller: _productController,
                type: TextInputType.text,
                validator: Validator.required,
              ),
              const SizedBox(height: 16),
              BlocConsumer<CategoriesCubit, CategoriesState>(
                listener: (context, state) {
                  if (state is CategoriesFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)),
                    );
                  }
                  if (state is CategoriesLoaded) {
                    setState(() => categories = state.categories);
                  }
                },
                builder: (context, state) {
                  return SelectInput(
                    title: "Категория",
                    hint: selectedCategory?.name ?? 'Выберите категорию',
                    onTap: () async {
                      int? categoryIndex =
                          await BottomSheetSelect.showSelectBottomSheet(
                        context: context,
                        items: categories.map((c) => c.name).toList(),
                        selectedItem: selectedCategory?.name,
                        title: 'Выберите категорию',
                      );
                      if (categoryIndex != null) {
                        setState(() {
                          selectedCategory =
                              categories.elementAt(categoryIndex);
                        });
                      }
                    },
                    loading: state is CategoriesLoading,
                  );
                },
              ),
              const SizedBox(height: 16),
              Input(
                title: "Телефон номер",
                hint: '(__) ___-__-__',
                maxLength: 9,
                controller: _phoneController,
                type: TextInputType.phone,
                validator: (value) => Validator.maxLength(value, 9),
              ),
              const SizedBox(height: 16),
              Input(
                title: "Адресс",
                hint: 'Введите свой адрес',
                controller: _addressController,
                type: TextInputType.text,
                validator: Validator.required,
              ),
              const SizedBox(height: 30),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                      ),
                    );
                  }
                  if (state is RegisterSuccess) {
                    Navigator.pushReplacement(
                      context,
                      SuccessPage.route(),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is RegisterLoading
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() == true &&
                                selectedCategory != null) {
                              BlocProvider.of<RegisterCubit>(context).register(
                                address: _addressController.text,
                                fullName: _nameController.text,
                                projectName: _productController.text,
                                categoryId: selectedCategory!.id,
                                phoneNumber: "998${_phoneController.text}",
                              );
                            }
                          },
                    child: const Text("Подать заявку"),
                  );
                },
              ),
              const TextDivider(text: "Если вы продавец, войдите на платформу"),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, LoginPage.route());
                },
                child: const Text("Войти"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
