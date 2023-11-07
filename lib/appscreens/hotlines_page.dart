import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class hotlinePage extends StatefulWidget {
  final String title = 'Hotlines';
  const hotlinePage({Key? key}) : super(key: key);

  @override
  State<hotlinePage> createState() => _hotlinePageState();
}

class _hotlinePageState extends State<hotlinePage> {
  bool _searchBoolean = false;
  List<int> _searchIndexList = [];

  final List<String> _list = [
    'Alcohol Abuse and Crisis Intervention',
    'Alcohol and Drug Abuse Helpline and Treatment',
    'Alcohol Treatment Referral Hotline (24 hours)',
    'American Family Housing',
    'Boystown National Hotline',
    'CDC National HIV and AIDS Hotline',
    'Child Abuse Hotline / Dept of Social Services',
    'Child Abuse National Hotline',
    'Childhelp National Child Abuse Hotline',
    'Children in immediate danger',
    'Cocaine Hotline (24 hours)',
    'Compulsive Gambling Hotline',
    'Crisis Pregnancy Hotline Number',
    'Depression Hotline',
    'Domestic Abuse Helpline for Men and Women',
    'Drug Abuse National Helpline',
    'Eating Disorders Awareness and Prevention',
    'Eating Disorders Center',
    'Ecstasy Addiction',
    'Elder Abuse Hotline',
    'Exploitation of Children',
    'Families Anonymous',
    'Family Violence Prevention Center',
    'Gay and Lesbian National Hotline',
    'GriefShare',
    'Hearing Impaired',
    'Helpline',
    'Homeless',
    'Hotline for parents considering abducting their children',
    'LGBT Youth Suicide Hotline',
    'Marijuana Anonymous',
    'Missing Children Help Center',
    'National Abortion Federation Hotline',
    'National Association of Anorexia Nervosa and Associated Disorders',
    'National Association for Children of Alcoholics',
    'National Child Abuse Hotline',
    'National Domestic Violence Hotline',
    'National Domestic Violence Hotline Spanish',
    'National Grad Crisis Line',
    'National Human Trafficking Hotline',
    'National Office of Post Abortion Trauma',
    'National Runaway Safeline',
    'National Sexual Assault Hotline',
    'National Suicide and Crisis Lifeline',
    'National Suicide Hotline',
    'National Suicide Prevention Lifeline',
    'National Suicide Prevention Text line',
    'National Youth Crisis Hotline',
    'Parent Hotline',
    'Post Abortion Counseling',
    'Safe Helpline',
    'Safe Horizon',
    'Self- injury Hotline',
    'Social Security Administration',
    'Stop it Now!',
    'Substance Abuse and Mental Health Services Administration National Helpline',
    'Teen Hope Line',
    'United States Missing Children Hotline',
    'United Way Crisis Helpline',
    'Youth Crisis Hotline',
  ];

  final List<String> _phoneNumber = [
    '18002340246',
    '18002340420',
    '18002526465',
    '18886004357',
    '18004483000',
    '18002324636',
    '18003423720',
    '18002522873',
    '18004224453',
    '18008435678',
    '18002622463',
    '14103320402',
    '18006722296',
    '16304829696',
    '18887435754',
    '18006624357',
    '18009312237',
    '18882361188',
    '18004686933',
    '18002528966',
    '18008435678',
    '18007369805',
    '18003131310',
    '18888434564',
    '18003955755',
    '18004481833',
    '18003984297',
    '18002316946',
    '18002929688',
    '18664887386',
    '18007666779',
    '18008725437',
    '18007729100',
    '18478313438',
    '18885542627',
    '18004224453',
    '18007997233',
    '18009426908',
    '18774723457',
    '18883737888',
    '18005932273',
    '18007862929',
    '18006564673',
    '988',
    '18007842433',
    '18002738255',
    '18007994889',
    '18004484663',
    '18008406537',
    '18002280332',
    '18779955247',
    '18006214673',
    '18003668288',
    '18007721213',
    '18887738368',
    '18006624357',
    '18003944673',
    '18002353535',
    '18002334357',
    '18004484663',
  ];

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchIndexList = [];
          for (int i = 0; i < _list.length; i++) {
            if (_list[i].contains(s)) {
              _searchIndexList.add(i);
            }
            if ((_list[i].toLowerCase()).contains(s.toLowerCase())) {
              _searchIndexList.add(i);
            }
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'SourceSans',
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
          fontFamily: 'SourceSans',
        ),
      ),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount: _searchIndexList.length,
        itemBuilder: (context, index) {
          index = _searchIndexList[index];
          return Card(
              child: ListTile(
            title: Text(_list[index]),
            onTap: () {
              _launchPhoneURL(_phoneNumber[index]);
            },
          ));
        });
  }

  Widget _defaultListView() {
    return ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_list[index]),
              onTap: () {
                _launchPhoneURL(_phoneNumber[index]);
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: !_searchBoolean ? Text(widget.title) : _searchTextField(),
            backgroundColor: const Color(0xFF115D6C),
            actions: !_searchBoolean
                ? [
                    IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _searchBoolean = true;
                            _searchIndexList = [];
                          });
                        })
                  ]
                : [
                    IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchBoolean = false;
                          });
                        })
                  ]),
        body: !_searchBoolean ? _defaultListView() : _searchListView());
  }
}

_launchPhoneURL(String phoneNumber) async {
  var url = Uri.parse("tel:" + phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
