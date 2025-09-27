import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel viewModel = Get.put(ProfileViewModel());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(() => viewModel.isLoading.value
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context, viewModel),
                  const SizedBox(height: 20),
                  _buildStatsSection(context, viewModel),
                  const SizedBox(height: 20),
                  _buildMenuSection(context, viewModel),
                  const SizedBox(height: 20),
                ],
              ),
            )),
    );
  }

  Widget _buildHeader(BuildContext context, ProfileViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      decoration: BoxDecoration(
           color:  Colors.pink,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildRoleChip(context, viewModel, UserRole.client),
                  const SizedBox(width: 8),
                  _buildRoleChip(context, viewModel, UserRole.stylist),
                  const SizedBox(width: 8),
                  _buildRoleChip(context, viewModel, UserRole.admin),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(viewModel.userImage.value),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.userName.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      viewModel.userEmail.value,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      viewModel.userPhone.value,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: viewModel.editProfile,
                icon: const Icon(Icons.edit, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleChip(BuildContext context, ProfileViewModel viewModel, UserRole role) {
    final isSelected = viewModel.userRole.value == role;
    return GestureDetector(
      onTap: () => viewModel.switchRole(role),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          role.name.toUpperCase(),
          style: TextStyle(
            color: isSelected ? Theme.of(context).primaryColor : Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, ProfileViewModel viewModel) {
    if (viewModel.userRole.value == UserRole.admin) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            'Total Bookings',
            viewModel.totalBookings.value.toString(),
            Icons.calendar_today,
            context,
          ),
          _buildStatItem(
            viewModel.userRole.value == UserRole.client ? 'Completed' : 'Services',
            viewModel.completedServices.value.toString(),
            Icons.check_circle,
            context,
          ),
          _buildStatItem(
            'Rating',
            viewModel.rating.value.toString(),
            Icons.star,
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context, ProfileViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.menuItems.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = viewModel.menuItems[index];
          final icon = viewModel.menuIcons[index];
          final isLogout = item == 'Logout';

          return ListTile(
            leading: Icon(
              icon,
              color: isLogout ? Colors.red : Theme.of(context).primaryColor,
            ),
            title: Text(
              item,
              style: TextStyle(
                color: isLogout ? Colors.red : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isLogout ? Colors.red : Colors.grey,
            ),
            onTap: () => viewModel.onMenuItemTap(index),
          );
        },
      ),
    );
  }
}