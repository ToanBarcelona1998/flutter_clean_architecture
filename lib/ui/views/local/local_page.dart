import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/bloc/bloc.dart';
import 'package:flutter_clean_architecture/config/config.dart';
import 'package:flutter_clean_architecture/core/core.dart';

class LocalPage extends StatefulWidget {
  const LocalPage({Key? key}) : super(key: key);

  @override
  _LocalPageState createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {
  late ScrollController _controller;
  late ArticleLocalBloc _articleBloc;

  late int _indexItemSelect=-1;

  // bool _decisionShow = false, _isShow = false;

  double _offsetItem = 0.0 , _offsetStart = 0.0 , _offsetUpdate = 0.0;

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
          if (previous == current) {
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
          return Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.listArticle?.length,
                itemBuilder: (builder, index) {
                  return Container(
                    padding: const EdgeInsetsDirectional.only(start: 14, end: 14, bottom: 7, top: 7),
                    height: context.screenSize.width / 2.2,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _articleBloc.add(
                              RemoveLocalArticleEvent(article: state.listArticle![index]),
                            ),
                            child: Container(
                              height: double.maxFinite,
                              width: 100,
                              decoration: const BoxDecoration(
                                color: AppTheme.checkColor,
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        customItem(index, state),
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
    );
  }

  Widget customItem(index ,state){
    return Transform.translate(
      offset: Offset(_indexItemSelect == index ? _offsetItem : 0, 0),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          _offsetStart = details.localPosition.dx;
          setState(() {

          });
        },
        onHorizontalDragStart: (details) {
          _indexItemSelect = index;
          _offsetUpdate = details.localPosition.dx;

          if(_offsetStart - _offsetUpdate >0 && _offsetStart - _offsetUpdate < 80){
              _offsetItem = _offsetUpdate - _offsetStart;
          }
          if(_offsetStart - _offsetUpdate <0 && _offsetStart - _offsetUpdate > 80){
            _offsetItem = -80 + (_offsetUpdate - _offsetStart);
          }
          if(_offsetStart - _offsetUpdate > 80){
            _offsetItem = _offsetUpdate - _offsetStart + 80;
          }
          if(_offsetStart - _offsetItem >0){
            _offsetItem = _offsetUpdate - _offsetStart;
          }
          setState(() {

          });
        },
        onHorizontalDragEnd: (details) {
          _offsetItem = -80;
          setState(() {

          });
        },
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
      ),
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
