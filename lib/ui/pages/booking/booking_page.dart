import 'package:buscatelo/model/hotel_model.dart';
import 'package:buscatelo/ui/pages/booking/booking_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  final HotelModel hotel;
  final Room? selectedRoom;

  const BookingPage({
    Key? key,
    required this.hotel,
    this.selectedRoom,
  }) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _adults = 2;
  int _children = 0;
  int _rooms = 1;
  String _selectedRoomType = '';
  String _selectedPaymentMethod = 'Credit Card';
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final List<String> _roomTypes = [
    'Standard Room',
    'Deluxe Room',
    'Suite',
    'Presidential Suite',
  ];

  final List<String> _paymentMethods = [
    'Credit Card',
    'PayPal',
    'Apple Pay',
    'Google Pay',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
    
    // Set default dates
    _checkInDate = DateTime.now().add(Duration(days: 1));
    _checkOutDate = DateTime.now().add(Duration(days: 3));
    _selectedRoomType = widget.selectedRoom?.name ?? _roomTypes[0];
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hotel Info Card
                _buildHotelInfoCard(),
                
                SizedBox(height: 24),
                
                // Date Selection
                _buildDateSelection(),
                
                SizedBox(height: 24),
                
                // Guest Information
                _buildGuestInformation(),
                
                SizedBox(height: 24),
                
                // Room Selection
                _buildRoomSelection(),
                
                SizedBox(height: 24),
                
                // Payment Information
                _buildPaymentInformation(),
                
                SizedBox(height: 24),
                
                // Price Summary
                _buildPriceSummary(),
                
                SizedBox(height: 100), // Bottom padding
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Book Your Stay',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildHotelInfoCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.hotel.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hotel.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.hotel.address,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Dates',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildDateField(
                  'Check-in',
                  _checkInDate,
                  Icons.calendar_today,
                  () => _selectDate(true),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildDateField(
                  'Check-out',
                  _checkOutDate,
                  Icons.calendar_today,
                  () => _selectDate(false),
                ),
              ),
            ],
          ),
          if (_checkInDate != null && _checkOutDate != null) ...[
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF6732c1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.hotel,
                    color: Color(0xFF6732c1),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${_checkOutDate!.difference(_checkInDate!).inDays} nights',
                    style: TextStyle(
                      color: Color(0xFF6732c1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.grey[600], size: 16),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              date != null 
                  ? DateFormat('MMM dd, yyyy').format(date)
                  : 'Select date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: date != null ? Colors.black87 : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestInformation() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Guest Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20),
          _buildTextField('Full Name', _nameController, Icons.person),
          SizedBox(height: 16),
          _buildTextField('Email', _emailController, Icons.email),
          SizedBox(height: 16),
          _buildTextField('Phone', _phoneController, Icons.phone),
          SizedBox(height: 20),
          _buildGuestCounter(),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF6732c1)),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildGuestCounter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Guests & Rooms',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        _buildCounterRow('Adults', _adults, (value) => setState(() => _adults = value)),
        SizedBox(height: 12),
        _buildCounterRow('Children', _children, (value) => setState(() => _children = value)),
        SizedBox(height: 12),
        _buildCounterRow('Rooms', _rooms, (value) => setState(() => _rooms = value)),
      ],
    );
  }

  Widget _buildCounterRow(String label, int value, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        Row(
          children: [
            _buildCounterButton(
              icon: Icons.remove,
              onPressed: value > 1 ? () => onChanged(value - 1) : null,
            ),
            SizedBox(width: 16),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 16),
            _buildCounterButton(
              icon: Icons.add,
              onPressed: () => onChanged(value + 1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCounterButton({required IconData icon, VoidCallback? onPressed}) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: onPressed != null ? Color(0xFF6732c1) : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18),
        color: onPressed != null ? Colors.white : Colors.grey[500],
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildRoomSelection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room Type',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          ..._roomTypes.map((type) => _buildRoomTypeOption(type)),
        ],
      ),
    );
  }

  Widget _buildRoomTypeOption(String type) {
    final isSelected = _selectedRoomType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedRoomType = type),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF6732c1).withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFF6732c1) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Color(0xFF6732c1) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Color(0xFF6732c1) : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Comfortable and spacious',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\$${_getRoomPrice(type)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6732c1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getRoomPrice(String type) {
    switch (type) {
      case 'Standard Room':
        return 120;
      case 'Deluxe Room':
        return 180;
      case 'Suite':
        return 280;
      case 'Presidential Suite':
        return 500;
      default:
        return 120;
    }
  }

  Widget _buildPaymentInformation() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          ..._paymentMethods.map((method) => _buildPaymentOption(method)),
          SizedBox(height: 20),
          if (_selectedPaymentMethod == 'Credit Card') ...[
            Text(
              'Card Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            _buildTextField('Card Number', _cardNumberController, Icons.credit_card),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('MM/YY', _expiryController, Icons.calendar_today),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildTextField('CVV', _cvvController, Icons.security),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method) {
    final isSelected = _selectedPaymentMethod == method;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = method),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF6732c1).withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFF6732c1) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Color(0xFF6732c1) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Color(0xFF6732c1) : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
            ),
            SizedBox(width: 16),
            Icon(
              _getPaymentIcon(method),
              color: isSelected ? Color(0xFF6732c1) : Colors.grey[600],
              size: 24,
            ),
            SizedBox(width: 16),
            Text(
              method,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPaymentIcon(String method) {
    switch (method) {
      case 'Credit Card':
        return Icons.credit_card;
      case 'PayPal':
        return Icons.payment;
      case 'Apple Pay':
        return Icons.apple;
      case 'Google Pay':
        return Icons.android;
      default:
        return Icons.payment;
    }
  }

  Widget _buildPriceSummary() {
    final roomPrice = _getRoomPrice(_selectedRoomType);
    final nights = _checkOutDate != null && _checkInDate != null
        ? _checkOutDate!.difference(_checkInDate!).inDays
        : 1;
    final subtotal = roomPrice * nights * _rooms;
    final tax = subtotal * 0.1;
    final total = subtotal + tax;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20),
          _buildPriceRow('Room Rate', '\$$roomPrice × $nights nights × $_rooms rooms'),
          SizedBox(height: 8),
          _buildPriceRow('Subtotal', '\$${subtotal.toStringAsFixed(0)}'),
          SizedBox(height: 8),
          _buildPriceRow('Tax (10%)', '\$${tax.toStringAsFixed(0)}'),
          Divider(height: 32),
          _buildPriceRow('Total', '\$${total.toStringAsFixed(0)}', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? Color(0xFF6732c1) : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: _canProceed() ? _confirmBooking : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6732c1),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            'Confirm Booking',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  bool _canProceed() {
    return _checkInDate != null &&
        _checkOutDate != null &&
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty;
  }

  void _selectDate(bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? _checkInDate ?? DateTime.now() : _checkOutDate ?? DateTime.now(),
      firstDate: isCheckIn ? DateTime.now() : _checkInDate ?? DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF6732c1),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          if (_checkOutDate != null && _checkOutDate!.isBefore(_checkInDate!)) {
            _checkOutDate = _checkInDate!.add(Duration(days: 1));
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  void _confirmBooking() {
    final roomPrice = _getRoomPrice(_selectedRoomType);
    final nights = _checkOutDate != null && _checkInDate != null
        ? _checkOutDate!.difference(_checkInDate!).inDays
        : 1;
    final subtotal = roomPrice * nights * _rooms;
    final tax = subtotal * 0.1;
    final total = subtotal + tax;
    
    final bookingId = 'BK${DateTime.now().millisecondsSinceEpoch}';
    
    // Navigate to confirmation page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmationPage(
          hotel: widget.hotel,
          bookingId: bookingId,
          checkInDate: _checkInDate!,
          checkOutDate: _checkOutDate!,
          roomType: _selectedRoomType,
          totalAmount: total.toInt(),
        ),
      ),
    );
  }
}
