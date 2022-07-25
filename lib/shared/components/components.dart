import 'package:flutter/material.dart';
import 'package:newsapp/shared/style/cubit_them.dart';

Widget buildNews(
    {required String title,
    required String date,
    required String image,
    required BuildContext context,
    required VoidCallback onTap
    }) {
  return InkWell(
    onTap:onTap ,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,

                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
