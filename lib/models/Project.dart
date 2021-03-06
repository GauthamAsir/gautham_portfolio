class Project {
  final String? title, description, longDesc;

  const Project({this.title, this.description, this.longDesc});
}

const List<Project> demo_projects = [
  Project(
      title: "E-Commerce App - Android XML UI",
      description:
          "It is an online sweet shopping application, with admin panel and live tracking for orders placed. It also has E-mail based notification for order status change.",
      longDesc:
          'It is an online sweet shopping application, with admin panel and live tracking for orders placed. It also has E-mail based notification for order status change.'
          'It is an online sweet shopping application, with admin panel and live tracking for orders placed. It also has E-mail based notification for order status change.'),
  Project(
      title: "E-Commerce App - Flutter UI",
      description:
          "It is an online raw meat(fish, chicken, mutton) shopping application, with admin panel and live tracking for orders placed. It also has E-mail based notification for order status change.",
      longDesc:
          'It is an online sweet shopping application, with admin panel and live tracking for orders placed. It also has E-mail based notification for order status change.'),
  Project(
      title: "Stock Wiki",
      description:
          "This app shows the advised stock but the experts, in which you can invest in minimum risks",
      longDesc:
          'This app shows the advised stock but the experts, in which you can invest in minimum risks'),
  Project(
      title: "WhatsApp Status Saver - Android XML UI",
      description:
          "This app helps you to save/share the whatsapp status posted by your friends. Works on Android 10+ too.",
      longDesc:
          'It is an online sweet shopping application, with admin panel and live tracking for orders placed. It also has E-mail based notification for order status change.'),
  Project(
      title: "File Manager - Flutter UI",
      description:
          "This app is a file manager which allows you to read, write, delete files in your android phone. Dark mode available",
      longDesc:
          'It is an online sweet shopping application, with admin panel and live tracking for orders placed. It also has E-mail based notification for order status change.'),
  Project(
      title: "Smart Home Control - Android XMl UI",
      description:
          "This app allows you to remotely control the switches which are customized(used Raspberry Pi) and configured in your home, uses firebase as database.",
      longDesc:
          'It is an online sweet shopping application, with admin panel and live tracking for orders placed. It also has E-mail based notification for order status change.'),
  // Project(
  //   title: "Image Editor - Android XMl UI",
  //   description:
  //       "It is a Photo editing application which can add multiple photos & add texts and backgrounds to create memes.",
  // ),
];
