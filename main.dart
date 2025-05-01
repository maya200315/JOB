import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



void main() async{ 
    WidgetsFlutterBinding.ensureInitialized();
  runApp(const JobApp());
}


class JobApp extends StatelessWidget {
  const JobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Job App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // انتقال بعد 3 ثواني
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            SizedBox(height: 20),
            Text(
              'Welcome in Job 💼',
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your career starts here',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // دالة لتسجيل الدخول
  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showMessage("يرجى تعبئة جميع الحقول");
    } else {
      // تحقق بسيط
      if (username == "admin" && password == "1234") {
              Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminPage()),);
      } else {
        _showMessage("اسم المستخدم أو كلمة المرور غير صحيحة ❌");
      }
    }
  }

  // دالة لإنشاء حساب
 void _signUp() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const RoleSelectionPage()),
  );

              }


  

  // دالة لعرض رسائل SnackBar
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepPurple,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 20),

              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              // حقل اسم المستخدم
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),

              // حقل كلمة المرور
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 30),

              // زر تسجيل الدخول
              SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                         ),
                                                       ),
                        child: const Text(
                           'Login',
                          style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, 
                                          ),
                                         ),
                                             ),
                      ),

              

              // زر إنشاء حساب
              TextButton(
                onPressed: _signUp,
                child: const Text(
                  'Don\'t have an account? Sign up',
                  style: TextStyle(color: Colors.deepPurple),
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({Key? key}) : super(key: key);

  @override
  _RoleSelectionPageState createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  String? selectedRole;

  void selectRole(String role) {
    setState(() {
      selectedRole = role;
    });


      // الانتقال حسب الدور المختار
  if (role == 'Center') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CenterRegistrationPage()),
    );
  } else {
    if (role == 'Employer'){
      Navigator.push(
     context,
      MaterialPageRoute(builder: (context) => const EmployerRegisterPage()),
                    );

    }else {
      if(role =='Job seeker'){
           //للانتقال لصفحة الباحث 
      }

    }
    
  }
  }

  Widget buildRoleButton(String role) {
    final isSelected = selectedRole == role;
    return ElevatedButton(
      onPressed: () => selectRole(role),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.deepPurple : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(role),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Type'),
        titleTextStyle: const TextStyle(color: Colors.white , fontSize: 21 ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please choose your account:',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            buildRoleButton('Center'),
            const SizedBox(height: 15),
            buildRoleButton('Job Seeker'),
            const SizedBox(height: 15),
            buildRoleButton('Employer'),
            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}


class CenterRegistrationPage extends StatefulWidget {
  const CenterRegistrationPage({Key? key}) : super(key: key);

  @override
  _CenterRegistrationPageState createState() => _CenterRegistrationPageState();
}

class _CenterRegistrationPageState extends State<CenterRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _centerNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // هون ارسال البيانات 
      Navigator.pushReplacement(
     context,
      MaterialPageRoute(builder: (context) => const CoursesPage()),
      );
    }
  }

  Widget _buildCustomTextField({
    required String label,
    required TextEditingController controller,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        validator: (value) => value == null || value.isEmpty ? 'Please enter $label' : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text(
          'Center Regesting',
          style: TextStyle(fontWeight: FontWeight.bold , color: Color.fromARGB(255, 238, 238, 238)),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildCustomTextField(
                    label: 'User name ',
                    controller: _usernameController,
                    icon: Icons.person,
                  ),
                  _buildCustomTextField(
                    label: 'Password ',
                    controller: _passwordController,
                    obscure: true,
                    icon: Icons.lock,
                  ),
                  _buildCustomTextField(
                    label: 'Center name ',
                    controller: _centerNameController,
                    icon: Icons.business,
                  ),
                  _buildCustomTextField(
                    label: 'Location',
                    controller: _locationController,
                    icon: Icons.location_on,
                  ),
                  _buildCustomTextField(
                    label: 'Mobile ',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    icon: Icons.phone,
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text(
                      'Submit ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class Course {
  String name;
  String specialty;
  String instructor;
  String time;
  String cost;

  Course({
    required this.name,
    required this.specialty,
    required this.instructor,
    required this.time,
    required this.cost,
  });
}

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Course> _courses = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _instructorController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _costController = TextEditingController();

  void _addCourse() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _courses.add(
          Course(
            name: _nameController.text,
            specialty: _specialtyController.text,
            instructor: _instructorController.text,
            time: _timeController.text,
            cost: _costController.text,
          ),
        );
        _nameController.clear();
        _specialtyController.clear();
        _instructorController.clear();
        _timeController.clear();
        _costController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Courses',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_nameController, 'Course Name'),
              _buildTextField(_specialtyController, 'Specialty'),
              _buildTextField(_instructorController, 'Instructor Name'),
              _buildTextField(_timeController, 'Course Time'),
              _buildTextField(_costController, 'Course Cost', keyboard: TextInputType.number),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addCourse,
                child: const Text('Add Course'),
              ),
              const SizedBox(height: 30),
              if (_courses.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Registered Courses:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ..._courses.map((course) => Card(
                          child: ListTile(
                            title: Text(course.name),
                            subtitle: Text(
                                'Specialty: ${course.specialty}\nInstructor: ${course.instructor}\nTime: ${course.time}\nCost: ${course.cost}'),
                          ),
                        )),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) => value!.isEmpty ? 'Please enter $labelText' : null,
      ),
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}


class _AdminPageState extends State<AdminPage> {
  int selectedIndex = 0;

  final TextEditingController _specialtyController = TextEditingController();
  List<String> specialties = [];

  void _addSpecialty() {
    final specialty = _specialtyController.text.trim();
    if (specialty.isNotEmpty) {
      setState(() {
        specialties.add(specialty);
        _specialtyController.clear();
      });
    }
  }

  Widget _buildSpecialtyTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Add Specialization:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        TextField(
          controller: _specialtyController,
          decoration: const InputDecoration(
            labelText: 'Specialization',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _addSpecialty,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          child: const Text('Add'),
        ),
        const SizedBox(height: 20),
        const Text('Current Specializations:', style: TextStyle(fontSize: 16)),
        Expanded(
          child: ListView.builder(
            itemCount: specialties.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(specialties[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    specialties.removeAt(index);
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEvaluationsTab() {
    return const Center(
      child: Text('Evaluations will be shown here.', style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildRequestsTab() {
    return const Center(
      child: Text('Verification requests will be shown here.', style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildContent() {
    switch (selectedIndex) {
      case 0:
        return _buildSpecialtyTab();
      case 1:
        return _buildEvaluationsTab();
      case 2:
        return _buildRequestsTab();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
            alignment: WrapAlignment.spaceEvenly, // هذا بدل mainAxisAlignment
            spacing: 8.0, // مسافة بين الأزرار بشكل أفقي
           runSpacing: 8.0, // مسافة بين الأزرار بشكل عمودي إذا انتقل لسطر جديد
           children: [
           _buildTabButton('Specialties', 0),
           _buildTabButton('Evaluations', 1),
           _buildTabButton('Requests', 2),
  ],
),

          ),
          const Divider(),
          Expanded(child: Padding(padding: const EdgeInsets.all(12), child: _buildContent())),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = selectedIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.deepPurple : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(label),
    );
  }
}





class EmployerRegisterPage extends StatefulWidget {
  const EmployerRegisterPage({super.key});

  @override
  State<EmployerRegisterPage> createState() => _EmployerRegisterPageState();
}

class _EmployerRegisterPageState extends State<EmployerRegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _selectedSpecialty;
  File? _pickedImage;

  final List<String> _specialties = [
    'Programming',
    'Design',
    'markiting',
  ];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  void _registerEmployer() {
    if (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _companyNameController.text.isEmpty ||
        _selectedSpecialty == null ||
        _locationController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields and attach the brand image."),
          backgroundColor: Colors.deepPurple,
        ),
      );
      return;
    }

    // ريط البيانات 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("your requiernment send sucessfully ✅"),
        backgroundColor: Colors.green,
      ),
    );

    // تنظيف الحقول
    _usernameController.clear();
    _passwordController.clear();
    _companyNameController.clear();
    _locationController.clear();
    _phoneController.clear();
    setState(() {
      _selectedSpecialty = null;
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Employer regesting'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        titleTextStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255) ,
        fontSize: 20  
          ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField(_usernameController, "User name ", Icons.person),
            const SizedBox(height: 15),
            _buildTextField(_passwordController, "Password ", Icons.lock, obscure: true),
            const SizedBox(height: 15),
            _buildTextField(_companyNameController, "Company name ", Icons.business),
            const SizedBox(height: 15),
            _buildTextField(_locationController, "Location ", Icons.location_on),
            const SizedBox(height: 15),
            _buildTextField(_phoneController, "Mobile ", Icons.phone, keyboard: TextInputType.phone),
            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: _selectedSpecialty,
              hint: const Text("Speciality "),
              items: _specialties.map((specialty) {
                return DropdownMenuItem(
                  value: specialty,
                  child: Text(specialty),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSpecialty = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.work),
              ),
            ),

            const SizedBox(height: 20),

            // اختيار صورة العلامة التجارية
            InkWell(
              onTap: _pickImage,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: _pickedImage == null
                    ? const Center(child: Text("Please choose brand photo"))
                    : Image.file(_pickedImage!, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 30),

            // زر التسجيل
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _registerEmployer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Submit ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {bool obscure = false, TextInputType keyboard = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}










