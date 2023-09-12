import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gautham_portfolio/core/base_theme/colors.dart';
import 'package:gautham_portfolio/core/base_widgets/base_scaffold.dart';
import 'package:gautham_portfolio/core/base_widgets/base_text.dart';
import 'package:gautham_portfolio/generated/assets.dart';
import 'package:gautham_portfolio/misc/globals.dart';
import 'package:gautham_portfolio/models/project_model.dart';
import 'package:rive/rive.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main_screen';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int selectedIndex = -1;

  List<ProjectModel> projectsList = [];

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;

  handleState() {
    if (mounted) {
      setState(() {});
    }
  }

  void getAllProjects() {
    database.collection('Configs').doc('data').get().then((value) {
      debugPrint('=======<<<');
      // debugPrint(value.data().toString());
      var list = List.from((value.data() ?? {'projects': []})['projects'])
          .map((e) => ProjectModel.fromJson(e))
          .toList();
      projectsList.addAll(list);
      handleState();
      return null;
    });
  }

  void showOverlay() {
    OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(builder: (context) {
      final animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      );

      final width = Tween<double>(begin: 100, end: 200).animate(animation);
      final height = Tween<double>(begin: 100, end: 200).animate(animation);

      return Positioned(
        left: MediaQuery.of(context).size.width * 0.5,
        top: MediaQuery.of(context).size.height * .15,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Material(
            color: Colors.transparent,
            child: Hero(
              tag: '004',
              child: Container(
                // width: 500,
                // height: MediaQuery
                //     .of(context)
                //     .size
                //     .height -
                //     (MediaQuery
                //         .of(context)
                //         .size
                //         .height * .15) * 2,
                width: width.value,
                height: height.value,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.6),
                    boxShadow: [
                      BoxShadow(
                          color: CustomColors.accentColor,
                          offset: const Offset(0, 0),
                          spreadRadius: 1,
                          blurRadius: 20)
                    ]),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            selectedIndex = -1;
                            _controller.forward(from: 0.0);
                            _overlayEntry?.remove();
                            handleState();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      return ProjectDetailWidget(
        overlayEntry: _overlayEntry!,
        onClose: () {
          selectedIndex = -1;
          _controller.forward(from: 0.0);
          _overlayEntry?.remove();
          handleState();
        },
        controller: _animationController,
        height: height.value,
        width: width.value,
      );
    });
    overlayState.insert(_overlayEntry!);
  }

  @override
  void initState() {
    getAllProjects();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * .15,
            vertical: constraints.maxHeight * .05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            descriptionWidget(),
            Builder(builder: (context) {
              ProjectModel? projectModel;

              if (selectedIndex >= 0 &&
                  projectsList.isNotEmpty &&
                  selectedIndex <= projectsList.length) {
                projectModel = projectsList[selectedIndex];
              }

              return SizedBox(
                width: projectModel == null ? 0 : 80,
              );
            }),
            Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Builder(builder: (context) {
                    // ProjectModel? projectModel;
                    //
                    // if (selectedIndex >= 0 &&
                    //     projectsList.isNotEmpty &&
                    //     selectedIndex <= projectsList.length) {
                    //   projectModel = projectsList[selectedIndex];
                    // }

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: projectsList.length * 200,
                          ),
                          ...List.generate(projectsList.length + 1, (index) {
                            if (index < projectsList.length) {
                              return Positioned(
                                top: (index * 160).toDouble(),
                                right: (index % 2) != 0 ? 0 : 180,
                                child: Hero(
                                  tag: '004',
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                    onTap: () {
                                      selectedIndex = index;
                                      _controller.forward(from: 0.0);
                                      handleState();
                                      // showOverlay();
                                    },
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      // margin:
                                      //     const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(.6),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  projectsList[index].image ??
                                                      ''),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.white.withOpacity(.6),
                                                  BlendMode.colorBurn)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: CustomColors.accentColor,
                                                offset: const Offset(0, 0),
                                                spreadRadius: 1,
                                                blurRadius: 20)
                                          ]),
                                      // child: NetworkImageItem(
                                      //   projectsList[index].image ?? '',
                                      //   boxFit: BoxFit.cover,
                                      //   radius: 100,
                                      // ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Positioned(
                              top: (index * 160).toDouble(),
                              right: (index % 2) != 0 ? 0 : 180,
                              child: InkWell(
                                onTap: () {
                                  selectedIndex = -1;
                                  _controller.forward(from: 0.0);
                                  _overlayEntry?.remove();
                                  handleState();
                                },
                                child: Container(
                                    width: 200,
                                    height: 200,
                                    // margin:
                                    //     const EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(.6),
                                        boxShadow: [
                                          BoxShadow(
                                              color: CustomColors.accentColor,
                                              offset: const Offset(0, 0),
                                              spreadRadius: 1,
                                              blurRadius: 20)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const ProfileButton(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        BaseText(
                                          'Contact',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          }).toList()
                        ],
                      ),
                    );
                  }),
                ))
          ],
        ),
      );
    }));
  }

  Widget descriptionWidget() {
    ProjectModel? projectModel;

    if (selectedIndex >= 0 &&
        projectsList.isNotEmpty &&
        selectedIndex <= projectsList.length) {
      projectModel = projectsList[selectedIndex];
    }

    return Expanded(
        flex: 3,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'tag01',
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ClipRect(
                              child: SlideTransition(
                                position: _offsetAnimation,
                                child: child,
                              ),
                            );
                          },
                          child: ClipRect(
                            child: Align(
                              widthFactor: 1,
                              child: BaseText(
                                projectModel?.title ?? 'Hello, I am Gautham',
                                key: ValueKey(projectModel?.title ??
                                    'Hello, I am Gautham'),
                                style: TextStyle(
                                    color: CustomColors.whiteColor,
                                    fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ClipRect(
                              child: SlideTransition(
                                position: _offsetAnimation,
                                child: child,
                              ),
                            );
                          },
                          child: ClipRect(
                            child: Align(
                              widthFactor: 1,
                              child: BaseText(
                                  projectModel?.framework ??
                                      'Mobile Application Developer (Flutter)',
                                  key: ValueKey(projectModel?.framework ??
                                      'Mobile Application Developer (Flutter)'),
                                  style: TextStyle(
                                      color: CustomColors.whiteColor,
                                      fontSize: 22)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 2,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustomColors.accentColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4))),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ClipRect(
                      child: SlideTransition(
                        position: _offsetAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: ClipRect(
                    child: Align(
                      widthFactor: 1,
                      child: BaseText(
                        projectModel?.description ??
                            'Hello, I\'m Gautham - how\'s it going?',
                        key: ValueKey(projectModel?.description ??
                            'Hello, I\'m Gautham - how\'s it going?'),
                        style: TextStyle(
                            color: CustomColors.whiteColor,
                            fontSize: 16,
                            letterSpacing: 1,
                            wordSpacing: 1),
                      ),
                    ),
                  ),
                ),
                projectModel != null
                    ? const SizedBox()
                    : RichText(
                        text: TextSpan(
                            children: [
                            TextSpan(
                                text:
                                    'I\'m a self taught mobile application developer, living in Mumbai, India. Catch me on  ',
                                style: TextStyle(
                                    color: CustomColors.whiteColor,
                                    fontSize: 16)),
                            TextSpan(
                                text: 'Github',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: const TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                    fontSize: 16)),
                            TextSpan(
                                text: ' & ',
                                style:
                                    TextStyle(color: CustomColors.whiteColor)),
                            TextSpan(
                                text: ' Telegram ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontSize: 16)),
                          ],
                            style: const TextStyle(
                                letterSpacing: 1, wordSpacing: 1, height: 2))),
                const SizedBox(
                  height: 30,
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ClipRect(
                      child: SlideTransition(
                        position: _offsetAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: ClipRect(
                    child: Align(
                      widthFactor: 1,
                      child: BaseText(
                        projectModel?.longDesc ??
                            'Currently a Frontend Flutter developer at Stylabs.\nI have also been worked in backend technologies like',
                        key: ValueKey(
                          projectModel?.longDesc ??
                              'Currently a Frontend Flutter developer at Stylabs.\nI have also been worked in backend technologies like',
                        ),
                        style: TextStyle(
                            color: CustomColors.whiteColor,
                            fontSize: 16,
                            letterSpacing: 1,
                            wordSpacing: 1),
                      ),
                    ),
                  ),
                ),
                projectModel != null
                    ? const SizedBox()
                    : RichText(
                        text: TextSpan(
                            children: [
                            TextSpan(
                                text: ' .Net (Core),',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: TextStyle(
                                    color: Colors.red.shade200, fontSize: 16)),
                            TextSpan(
                                text: ' Java,',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: const TextStyle(
                                    color: Colors.orange, fontSize: 16)),
                            TextSpan(
                                text: ' MSQL,',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: TextStyle(
                                    color: Colors.indigo.shade300,
                                    fontSize: 16)),
                            TextSpan(
                                text: ' Supabase,',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 16)),
                            TextSpan(
                                text: ' Python,',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ],
                            style: const TextStyle(
                                letterSpacing: 1, wordSpacing: 1, height: 2))),
              ],
            ),
          ),
        ));
  }
}

class ProjectDetailWidget extends StatefulWidget {
  final OverlayEntry overlayEntry;
  final VoidCallback onClose;
  final AnimationController controller;
  final double width, height;

  const ProjectDetailWidget(
      {super.key,
      required this.overlayEntry,
      required this.onClose,
      required this.controller,
      required this.width,
      required this.height});

  @override
  State<ProjectDetailWidget> createState() => _ProjectDetailWidgetState();
}

class _ProjectDetailWidgetState extends State<ProjectDetailWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.5,
      top: MediaQuery.of(context).size.height * .15,
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) => Material(
          color: Colors.transparent,
          child: Hero(
            tag: '004',
            child: Container(
              // width: 500,
              // height: MediaQuery
              //     .of(context)
              //     .size
              //     .height -
              //     (MediaQuery
              //         .of(context)
              //         .size
              //         .height * .15) * 2,
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.6),
                  boxShadow: [
                    BoxShadow(
                        color: CustomColors.accentColor,
                        offset: const Offset(0, 0),
                        spreadRadius: 1,
                        blurRadius: 20)
                  ]),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          widget.onClose();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileButton extends StatefulWidget {
  const ProfileButton({super.key});

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  Artboard? _birdArtboard;
  SMIBool? hoverOut;

  StateMachineController? stateMachineController;

  @override
  void initState() {
    super.initState();

    RiveFile.asset(Assets.riveProfileRive).then((value) {
      Artboard artboard = value.artboards.first;

      artboard.forEachComponent(
        (child) {
          if (child is Fill) {
            Fill fill = child;
            fill.paint.color = Colors.black;
          } else if (child is Shape) {
            Shape shape = child;

            if (shape.fills.isNotEmpty) {
              shape.fills.first.paint.color = Colors.black;
            }
          }
        },
      );

      for (var element in artboard.fills) {
        element.paint.color = Colors.transparent;
      }

      stateMachineController =
          StateMachineController.fromArtboard(artboard, "State Machine 1");

      if (stateMachineController != null) {
        value.mainArtboard.addController(stateMachineController!);

        hoverOut = stateMachineController!.findSMI('Hover');
        if (hoverOut != null) {
          hoverOut?.change(false);
        }
      }

      _birdArtboard = value.mainArtboard;

      setState(() {});
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 75),
      child: InkWell(
        onHover: (val) {
          hoverOut?.change(val);
          // setState(() {});
        },
        hoverColor: Colors.transparent,
        onTap: () {},
        // child: Rive(artboard: ),
        child: _birdArtboard != null
            ? Rive(
                artboard: _birdArtboard!,
                fit: BoxFit.cover,
              )
            : const SizedBox(),
        // child:
        //     RiveAnimation.asset(Assets.riveBagRive, controllers: [_controller]),
        // child: _birdArtboard != null
        //     ? RiveAnimation.asset(
        //         Assets.riveBagRive,
        //       )
        //     : const SizedBox(),
      ),
    );
  }
}
