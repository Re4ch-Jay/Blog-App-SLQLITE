// ignore_for_file: use_build_context_synchronously

import 'package:blog_app/controllers/database_helper.dart';
import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/views/widgets/blog_button.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  final Blog? blog;
  FormScreen({
    super.key,
    this.blog,
  });

  final _titleTextEditingController = TextEditingController();

  final _descTextEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (blog != null) {
      _titleTextEditingController.text = blog!.title;
      _descTextEditingController.text = blog!.description;
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            blog == null ? 'Blog Post' : 'Blog Update',
            style: const TextStyle(color: Colors.amber),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleTextEditingController,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title is required';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: _descTextEditingController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Description is required';
                      } else {
                        return null;
                      }
                    },
                    maxLines: 20,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Success',
                              style: TextStyle(color: Colors.black),
                            ),
                            backgroundColor: Colors.amber,
                          ),
                        );

                        blog == null
                            ? await DatabaseHelper.add(
                                Blog(
                                    title: _titleTextEditingController.text,
                                    description:
                                        _descTextEditingController.text),
                              )
                            : await DatabaseHelper.update(
                                Blog(
                                    id: blog!.id,
                                    title: _titleTextEditingController.text,
                                    description:
                                        _descTextEditingController.text),
                              );

                        Navigator.pop(context);
                      }
                    },
                    child: BlogButton(blog: blog),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
