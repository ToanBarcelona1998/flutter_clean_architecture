import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/bloc/bloc.dart';
import 'package:flutter_clean_architecture/config/config.dart';
import 'package:flutter_clean_architecture/ui/ui.dart';
import 'package:flutter_clean_architecture/utils/utils.dart';

class LocalPage extends StatefulWidget {
  const LocalPage({Key? key}) : super(key: key);

  @override
  _LocalPageState createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {
  late ScrollController _controller;
  late ArticleLocalBloc _articleBloc;

  late int _indexItemSelect = -1;

  bool _decisionShow = false, _isShow = false;

  double _offsetItem = 0.0, _offsetStart = 0.0, _offsetUpdate = 0.0;

  @override
  void initState() {
    super.initState();
    _articleBloc = ArticleLocalBloc.of(context)..add(const GetLocalArticleEvent(isLoadMore: false));
    _controller = ScrollController()..addListener(_listen);
  }

  void _listen() {
    if (_controller.position.extentBefore == _controller.position.maxScrollExtent) {
      _articleBloc.add(const GetLocalArticleEvent(isLoadMore: true));
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    _articleBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<ArticleLocalBloc, ArticleLocalState>(
        buildWhen: (previous, current) {
          if (previous.props == current.props) {
            return false;
          }
          return true;
        },
        builder: (builder, state) {
          if (state is ArticleLocalStateLoading && !state.isLoadMore!) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is ArticleLocalStateDone && state.listArticle!.isEmpty) {
            return Center(
              child: Text(
                Message.emptyLocal,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            );
          }
          return Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.listArticle?.length,
                itemBuilder: (builder, index) {
                  return WidgetClaw(
                      height: 150,
                      child: customItem(index, state),
                      itemCount: 2,
                      index: index,
                      callBacks: [() => _articleBloc.add(RemoveLocalArticleEvent(article: state.listArticle![index])), () {}],
                      listColor: const [AppTheme.buttonDelete, AppTheme.buttonEdit],
                      icons: const [Icons.delete, Icons.edit]);
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
    );
  }

  Widget customItem(index, state) {
    return Row(
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
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(Message.localTitle),
      actions: [
        Builder(
          builder: (context) => GestureDetector(
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
