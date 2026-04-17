import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vinted_v2/core/constants/sizes.dart';
import 'package:vinted_v2/core/constants/text_strings.dart';
import 'package:vinted_v2/core/utils/validators/validators.dart';
import 'package:vinted_v2/features/authentication/controllers/signup_controller.dart';
import 'package:vinted_v2/features/authentication/presentation/widgets/terms_and_conditions_checkbox.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey, //? assign the key to the form
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      CustomValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: AppTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const Gap(AppSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      CustomValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: AppTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const Gap(AppSizes.spaceBtwInputFields),

          //* username
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                CustomValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
              labelText: AppTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const Gap(AppSizes.spaceBtwInputFields),

          //* email
          TextFormField(
            controller: controller.email,
            validator: (value) => CustomValidator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: AppTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const Gap(AppSizes.spaceBtwInputFields),

          //* phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => CustomValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: AppTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const Gap(AppSizes.spaceBtwInputFields),

          //* password
          Obx(
            //? wrap it with observer to redraw the widget on change
            () => TextFormField(
              controller: controller.password,
              validator: (value) => CustomValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: AppTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          const Gap(AppSizes.spaceBtwInputFields),

          //* terms&conditions checkbox
          const TermsAndConditionsCheckBox(),
          const Gap(AppSizes.spaceBtwItems),

          //* sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(AppTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
