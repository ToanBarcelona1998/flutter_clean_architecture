import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/bloc/bloc.dart';
import 'package:flutter_clean_architecture/config/config.dart' show AppTheme;
import 'package:flutter_clean_architecture/ui/ui.dart' show WidgetDialog;
import 'package:flutter_clean_architecture/utils/utils.dart'
    show BaseUrl, ContextExtension, Message, Navigate, StringExtension, imageOOPS;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _controller;

  late ArticleBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _articleBloc = ArticleBloc.of(context);
    _controller = ScrollController()..addListener(_listen);
  }

  void _listen() {
    if (_controller.position.extentBefore == _controller.position.maxScrollExtent) {
      _articleBloc.add(const GetArticleEvent(isLoadMore: true));
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    _articleBloc.refreshState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<ArticleBloc, ArticleState>(
        listener: (context, state) {
          if (state is ArticleStateError) {
            WidgetDialog.showHozDialog(context, title: Message.homeTitleDialog, content: state.error!);
          }
        },
        child: BlocBuilder<ArticleBloc, ArticleState>(
          buildWhen: (previous, current) {
            if (previous.props == current.props) {
              return false;
            }
            return true;
          },
          builder: (builder, state) {
            if (state is ArticleStateLoading && !state.isLoadMore!) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is ArticleStateError && !state.isLoadMore!) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    _articleBloc.add(const GetArticleEvent(isLoadMore: false));
                  },
                  child: const Icon(Icons.refresh),
                ),
              );
            }
            return Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.listArticle?.length,
                  itemBuilder: (builder, index) {
                    return Container(
                      padding: const EdgeInsetsDirectional.only(start: 14, end: 14, bottom: 7, top: 7),
                      height: context.screenSize.width / 2.2,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 14),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                width: context.screenSize.width / 3,
                                height: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.08),
                                ),
                                child: Image.network(
                                  state.listArticle?[index].urlImage ?? BaseUrl.errorImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) {
                                    return Image.asset(imageOOPS.assetImage);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.listArticle?[index].title ?? '',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        state.listArticle?[index].description ?? '',
                                        maxLines: 2,
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.timelapse_outlined, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        state.listArticle?[index].publishAt.toString() ?? '',
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  controller: _controller,
                ),
                state.isLoadMore!
                    ? Positioned(
                        bottom: 10,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(Message.homeTitle),
      actions: [
        Builder(
          builder: (context) => GestureDetector(
            onTap: () => Navigate.goLocal(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.bookmark, color: AppTheme.whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
