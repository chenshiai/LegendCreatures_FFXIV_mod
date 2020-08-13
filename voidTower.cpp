#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <string.h>
#define N 3

int hero1, hero2, hero3;
float hero1s, hero2s, hero3s;
float enemy1s, enemy2s, enemy3s;

struct PLAYER
{ //玩家数据
  int over;
  char Name[20];
  char rank[5];
  int victory;
  int defeat;
  int Class;
  int money;
} play = {0, "NULL", "NULL", 0, 0, 1, 0};

HANDLE handle = GetStdHandle(STD_OUTPUT_HANDLE); //获取控制台句柄

struct HERO
{ //基础数据，游戏内不可更改
  int num;
  char HeroName[20];
  float AD;
  float AP;
  float HP;
  float MP;
  float DK;
  float MK;
  float speet;
  char Skill1[20];
  char Skill2[20];
  char Skill3[20];
} hero[N] = {
    {1, "Warrior", 10, 0, 50, 20, 10, 6, 3, "Bash(5)", "Shield(5)", "Trial(8)"},
    {2, "Master", 4, 10, 35, 35, 6, 6, 2.8, "Burst(5)", "Surging(6)", "Despair(10)"},
    {3, "Assassin", 8, 0, 40, 20, 10, 10, 3.4, "Backstab(0)", "Poison(0)", "Cutthroat(0)"}},
  *new1 = hero;

struct ENEMY
{ //基础数据，游戏内不可更改
  int num;
  char enemyname[20];
  float AD;
  float AP;
  float HP;
  float MP;
  float DK;
  float MK;
  float speet;
} enemy[12] = {
    {1, "Dogface", 6, 0, 30, 10, 10, 0, 2.5},
    {2, "Batman", 8, 0, 33, 10, 6, 2, 2.6},
    {3, "Witch Man", 6, 10, 30, 25, 5, 8, 2.4},
    {4, "Madman", 10, 0, 35, 0, 3, 3, 2.7},
    {5, "General", 9, 2, 40, 10, 8, 5, 2.5},
    {6, "Ghost", 12, 0, 30, 0, 15, 0, 1.3},
    {7, "Kirito", 15, 10, 50, 10, 8, 2.3},
    {8, "Asuna", 14, 12, 45, 8, 8, 2.2},
    {9, "Inuyasha", 20, 10, 60, 10, 9, 6, 2.35},
    {10, "Luffy", 30, 20, 100, 20, 10, 6, 2.7},
    {11, "Chen Shi Ai", 40, 30, 100, 70, 30, 30, 3}};

struct LSienemy
{ //临时数据，游戏内科更改
  char name[20];
  float AD;
  float AP;
  float HP;
  float MP;
  float DK;
  float MK;
  float speet;
} lsenemy[4];

struct LSally
{ //临时数据，游戏内科更改
  char Name[20];
  float AD;
  float AP;
  float HP;
  float MP;
  float DK;
  float MK;
  float speet;
} lsally[4];

void Skill1(int hero, int man)
{
  void CommonAttack(int man);
  int a;
  float hurt;
  switch (hero)
  {
  case 1:
  {
    printf("\n\t\t\t    %s 发动 [Bash]\n\n", (lsally + man)->Name);
    printf(" Skill 1:%s    对敌方发动猛烈一击，造成（%.0f）点物理伤害。\n\t\t\t\tCD：2回合\n\n", (new1 + hero - 1)->Skill1, (lsally + man)->AD * 1.4);
    printf("\t\t\t请选择施放对象的编号（1-3）:");
    scanf("%d", &a);
    getchar();
    while (1)
    {
      if (a <= 3 && a >= 1 && (lsenemy + a - 1)->HP > 0)
      {
        hurt = (lsally + man)->AD * 1.4 - (lsally + man)->AD * 1.4 * (lsenemy + a - 1)->DK / ((lsenemy + a - 1)->DK + 10);
        (lsenemy + a - 1)->HP -= hurt;
        (lsally + man)->MP -= 5;
        break;
      }
      else
      {
        printf("\n\t\t\t选择了无效的目标！重新选择！");
        scanf("%d", &a);
        getchar();
      }
    }
    printf("\n\t\t %s 对敌方 %s 造成了 %.0f 点物理伤害。\n\n", (lsally + man)->Name, (lsenemy + a - 1)->name, hurt);
    system("pause");
    break;
  }
  case 2:
  {
    printf("\n\t\t\t    %s 发动 [Burst]\n\n", (lsally + man)->Name);
    printf(" Skill 1:%s    使用魔法引发爆炸，造成（%.0f）点魔法伤害。\n\t\t\t\tCD：2回合\n\n", (new1 + hero - 1)->Skill1, (lsally + man)->AP * 1.3);
    printf("\t\t\t请选择施放对象的编号（1-3）:");
    scanf("%d", &a);
    getchar();
    while (1)
    {
      if (a <= 3 && a >= 1 && (lsenemy + a - 1)->HP > 0)
      {
        hurt = (lsally + man)->AP * 1.3 - (lsally + man)->AP * 1.3 * (lsenemy + a - 1)->MK / ((lsenemy + a - 1)->MK + 10);
        (lsenemy + a - 1)->HP -= hurt;
        (lsally + man)->MP -= 5;
        break;
      }
      else
      {
        printf("\n\t\t\t选择了无效的目标！重新选择！");
        scanf("%d", &a);
        getchar();
      }
    }
    printf("\n\t\t %s 对敌方 %s 造成了 %.0f 点魔法伤害。\n\n", (lsally + man)->Name, (lsenemy + a - 1)->name, hurt);
    system("pause");
    break;
  }
  case 3:
  {
    CommonAttack(man);
    break;
  }
  default:
  {

    break;
  }
  }
}

void Skill2(int hero, int man)
{
  void CommonAttack(int man);
  int a;
  float hurt;
  switch (hero)
  {
  case 1:
  {
    printf("\n\t\t\t    %s 发动 [Shield]\n\n", (lsally + man)->Name);
    printf(" Skill 2:%s    为自己套上可以抵挡（%.0f）点伤害的护盾。\n\t\t\t\tCD：3回合\n\n", (new1 + hero - 1)->Skill2, (lsally + man)->DK * 0.8);
    (lsally + man)->HP += ((lsally + man)->DK * 0.8);
    (lsally + man)->MP -= 5;
    break;
  }
  case 2:
  {
    printf("\n\t\t\t    %s 发动 [Surging]\n\n", (lsally + man)->Name);
    printf(" Skill 2:%s    对所有敌方造成（%0.f）点魔法伤害。\n\t\t\t\tCD：2回合\n\n", (new1 + hero - 1)->Skill2, (lsally + man)->AP * 0.8);

    hurt = (lsally + man)->AP * 0.8 - (lsally + man)->AP * 0.8 * (lsenemy + 0)->MK / ((lsenemy + 0)->MK + 10)(lsenemy + 0)->HP -= hurt;
    printf("\n\t\t %s 对敌方 %s 造成了 %.0f 点魔法伤害。\n", (lsally + man)->Name, (lsenemy + 0)->name, hurt);

    hurt = (lsally + man)->AP * 0.8 - (lsally + man)->AP * 0.8 * (lsenemy + 1)->MK / ((lsenemy + 1)->MK + 10)(lsenemy + 1)->HP -= hurt;
    printf("\n\t\t %s 对敌方 %s 造成了 %.0f 点魔法伤害。\n", (lsally + man)->Name, (lsenemy + 1)->name, hurt);

    hurt = (lsally + man)->AP * 0.8 - (lsally + man)->AP * 0.8 * (lsenemy + 2)->MK / ((lsenemy + 2)->MK + 10)(lsenemy + 2)->HP -= hurt;
    printf("\n\t\t %s 对敌方 %s 造成了 %.0f 点魔法伤害。\n", (lsally + man)->Name, (lsenemy + 2)->name, hurt);

    system("pause");
    break;
  }
  case 3:
  {
    CommonAttack(man);
    break;
  }
  default:
  {
    break;
  }
  }
}

void Skill3(int hero, int man)
{
  void CommonAttack(int man);
  int a;
  float hurt;
  switch (hero)
  {
  case 1:
  {
    float cishu = 0;
    printf("\n\t\t\t    %s 发动 [Trial]\n\n", (lsally + man)->Name);
    printf(" Skill 3:%s    斩杀低生命值的敌方，可造成（%.0f）点魔法伤害。\n　　自己每损失5点HP，这个技能伤害+1。\n\t\t\t\tCD：3回合\n\n", (new1 + hero - 1)->Skill3, (lsally + man)->MK);
    printf("\t\t\t请选择施放对象的编号（1-3）:");
    scanf("%d", &a);
    getchar();
    while (1)
    {
      if (a <= 3 && a >= 1 && (lsenemy + a - 1)->HP > 0)
      {
        cishu = (new1 + hero - 1)->HP - (lsally + man)->HP;

        hurt = (lsally + man)->MK - (lsally + man)->MK * (lsenemy + a - 1)->MK / ((lsenemy + a - 1)->MK + 10);
        for (; cishu % 5 >= 0; cishu /= 5.0)
        {
          hurt += 1;
        }
        (lsenemy + a - 1)->HP -= hurt;
        (lsally + man)->MP -= 8;
        break;
      }
      else
      {
        printf("\n\t\t\t选择了无效的目标！重新选择！");
        scanf("%d", &a);
        getchar();
      }
    }
    printf("\n\t\t %s 对敌方 %s 造成了 %.0f 点魔法伤害。\n\n", (lsally + man)->Name, (lsenemy + a - 1)->name, hurt);
    system("pause");
    break;
  }
  case 2:
  {
    printf("\n\t\t\t    %s 发动 [Depair]\n\n", (lsally + man)->Name);
    printf(" Skill 3:%s    当敌方只剩一人时，则造成（%.0f）点魔法伤害。否则回复（%.0f）点HP、MP。\n\t\t\t\tCD：3回合\n\n", (new1 + hero - 1)->Skill3, (lsally + man)->AP * 2, (lsally + man)->AP);

    a = (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0 ? 1 : ((lsenemy + 0)->HP <= 0 && (lsenemy + 2)->HP <= 0 ? 2 : ((lsenemy + 0)->HP <= 0 && (lsenemy + 2)->HP <= 0 ? 3 : 0));

    if (a <= 3 && a >= 1 && (lsenemy + a - 1)->HP > 0)
    {
      hurt = (lsally + man)->AP * 2 - (lsally + man)->AP * 2 * (lsenemy + a - 1)->MK / ((lsenemy + a - 1)->MK + 10);
      (lsenemy + a - 1)->HP -= hurt;
      (lsally + man)->MP -= 10;

      printf("\n\t\t %s 对敌方 %s 造成了 %.0f 点魔法伤害。\n\n", (lsally + man)->Name, (lsenemy + a - 1)->name, hurt);
      system("pause");
      break;
    }
    else
    {
      (lsally + man)->HP += (lsally + man)->AP;
      (lsally + man)->MP += (lsally + man)->AP;
    }
  }
  case 3:
  {
    CommonAttack(man);
    break;
  }
  default:
  {
    break;
  }
  }
}

void menu()
{ //菜单显示
  fflush(stdin);
  system("mode con: cols=50 lines=30");
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf(" Ver:1.0");
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf("\n\n\n\n\n\t\t　　 CHENSHIAI\n\n\t\t*******************\n");
  printf("\t\t*   1 挑战关卡    *\n");
  printf("\t\t*   2 玩家信息    *\n");
  printf("\t\t*   3 游戏数据    *\n");
  printf("\t\t*   4 游戏教程    *\n");
  printf("\t\t*   5 清理缓存    *\n");
  printf("\t\t*   6 制作人员    *\n");
  printf("\t\t*   7 退出游戏    *\n");
  printf("\t\t*******************\n\n");
  printf("\t\t请选择：");
}

void allymove(int hero, int man)
{ //显示ally的回合
  void CommonAttack(int man);
  void Skill1(int hero, int man);
  void Skill2(int hero, int man);
  void Skill3(int hero, int man);

  int a;
  printf("\t\t\t\t 1.普通攻击。\n\n");
  printf("\t\t\t\t===技能攻击===\n");
  printf("\t\t\t\t 2.%s\n", (new1 + hero - 1)->Skill1);
  printf("\t\t\t\t 3.%s\n", (new1 + hero - 1)->Skill2);
  printf("\t\t\t\t 4.%s\n\n", (new1 + hero - 1)->Skill3);
  printf("\t\t\t\t 请选择：");
  scanf("%d", &a);
  switch (a)
  {
  case 1:
  {
    CommonAttack(man);
    break;
  }
  case 2:
  {
    Skill1(hero, man);
    break;
  }
  case 3:
  {
    Skill2(hero, man);
    break;
  }
  case 4:
  {
    Skill4(hero, man);
    break;
  }
  default:
  {
    printf(" 跳过.......\n");
    system("pause");
    break;
  }
  }
}

void enemymove(int enemy)
{
  void EAttack(int enemy);
  EAttack(enemy);
}

int SP()
{ //速度决定出手顺序
  int c = 0, l = 0;
  while (1)
  {
    hero1s += 0.01;
    hero2s += 0.01;
    hero3s += 0.01;

    enemy1s += 0.01;
    enemy2s += 0.01;
    enemy3s += 0.01;

    if (hero1s >= 5)
    {
      if ((lsally + 1)->HP > 0)
      {
        printf("\t\t\t\t现在轮到 %s<4> 出手了。\n\n", (lsally + 1)->Name);
        if ((lsally + 1)->MP < (new1 + hero1 - 1)->MP)
          (lsally + 1)->MP += 2;
        hero1s = (lsally + 1)->speet;
        allymove(hero1, 1);
        return 0;
      }
    }
    if (hero2s >= 5)
    {
      if ((lsally + 2)->HP > 0)
      {
        printf("\t\t\t\t现在轮到 %s<5> 出手了。\n\n", (lsally + 2)->Name);
        if ((lsally + 2)->MP < (new1 + hero2 - 1)->MP)
          (lsally + 2)->MP += 2;
        hero2s = (lsally + 2)->speet;
        allymove(hero2, 2);
        return 0;
      }
    }
    if (hero3s >= 5)
    {
      if ((lsally + 3)->HP > 0)
      {
        printf("\t\t\t\t现在轮到 %s<6> 出手了。\n\n", (lsally + 3)->Name);
        if ((lsally + 3)->MP < (new1 + hero3 - 1)->MP)
          (lsally + 3)->MP += 2;
        hero3s = (lsally + 3)->speet;
        allymove(hero3, 3);
        return 0;
      }
    }

    if (enemy1s >= 5)
    {
      if ((lsenemy + 0)->HP > 0)
      {
        printf("\t\t\t\t现在轮到 %s<1> 出手了。\n\n", (lsenemy + 0)->name);
        enemy1s = (lsenemy + 0)->speet;
        enemymove(0);
        return 0;
      }
    }
    if (enemy2s >= 5)
    {
      if ((lsenemy + 1)->HP > 0)
      {
        printf("\t\t\t\t现在轮到 %s<2> 出手了。\n\n", (lsenemy + 1)->name);
        enemy2s = (lsenemy + 1)->speet;
        enemymove(1);
        return 0;
      }
    }
    if (enemy3s >= 5)
    {
      if ((lsenemy + 2)->HP > 0)
      {
        printf("\t\t\t\t现在轮到 %s<3> 出手了。\n\n", (lsenemy + 2)->name);
        enemy3s = (lsenemy + 2)->speet;
        enemymove(2);
        return 0;
      }
    }
  }
}

void CommonAttack(int man)
{ //mam(1-3)ally普通攻击
  int a;
  float hurt;
  printf("\n\t\t\t %s 发动 [普通攻击]\n\n", (lsally + man)->Name);
  printf("\t\t\t请选择攻击单位的编号（1~3）:");
  scanf("%d", &a);
  while (1)
  {
    if (a <= 3 && a >= 1 && (lsenemy + a - 1)->HP > 0)
    {
      hurt = (lsally + man)->AD - (lsally + man)->AD * (lsenemy + a - 1)->DK / ((lsenemy + a - 1)->DK + 10);
      (lsenemy + a - 1)->HP -= hurt;
      break;
    }
    else
    {
      printf("\n\t\t\t选择了无效的目标！重新选择！");
      scanf("%d", &a);
      getchar();
    }
  }
  printf("\n\t\t %s 对敌方 %s 造成了 %.0f 点物理伤害。\n\n", (lsally + man)->Name, (lsenemy + a - 1)->name, hurt);
  system("pause");
}

void EAttack(int enemy)
{
  float hurt;
  int a;
  a = (lsally + 1)->HP >= (lsally + 2)->HP ? 1 : ((lsally + 2)->HP >= (lsally + 3)->HP ? 2 : 3);
  printf("\t\t\t%s 对 %s 发动 [普通攻击]\n\n", (lsenemy + enemy)->name, (lsally + a)->Name);
  hurt = ((lsenemy + enemy)->AD - (lsenemy + enemy)->AD * (lsally + a)->DK / ((lsally + a)->DK + 10));
  (lsally + a)->HP -= hurt;
  printf("\t\t\t  造成了 %.0f 点物理伤害。\n\n", hurt);
  system("pause");
}

void Class(int num)
{ //关卡显示
  void enemylook();
  void allylook();
  system("cls");
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf("=====================================第%2d关=====================================", num);
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  enemylook();
  allylook();
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf("\n================================================================================");
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
}

void enemylook()
{ //显示敌人数据
  int c = 0, l = 0;

  HANDLE enemy1;
  COORD LiftTop = {c + 9, l + 2};
  enemy1 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy1, LiftTop); //移动光标位置到左上

  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf("%s(1)\n", (lsenemy + 0)->name);
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);

  COORD LiftTop1 = {c + 4, l + 3};
  enemy1 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy1, LiftTop1);

  printf("ＨＰ:%3.0f 　ＭＰ:%3.0f", (lsenemy + 0)->HP, (lsenemy + 0)->MP);

  COORD LiftTop2 = {c + 4, l + 4};
  enemy1 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy1, LiftTop2);

  printf("ＡＤ:%3.0f   ＡＰ:%3.0f", (lsenemy + 0)->AD, (lsenemy + 0)->AP);

  COORD LiftTop3 = {c + 4, l + 5};
  enemy1 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy1, LiftTop3);

  printf("ＤＫ:%3.0f   ＭＫ:%3.0f", (lsenemy + 0)->DK, (lsenemy + 0)->MK);

  COORD LiftTop4 = {c + 4, l + 6};
  enemy1 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy1, LiftTop4);

  printf("ｓｐ:%g", (lsenemy + 0)->speet);

  if ((lsenemy + 0)->HP <= 0)
  {
    COORD live1 = {c + 14, l + 6};
    enemy1 = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleCursorPosition(enemy1, live1);

    printf("已阵亡");
  }

  HANDLE enemy2;
  COORD MidTop = {c + 35, l + 2};
  enemy2 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy2, MidTop); //移动光标位置到上中

  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf("%s(2)\n", (lsenemy + 1)->name);
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);

  COORD MidTop1 = {c + 30, l + 3};
  enemy2 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy2, MidTop1);

  printf("ＨＰ:%3.0f　 ＭＰ:%3.0f", (lsenemy + 1)->HP, (lsenemy + 1)->MP);

  COORD MidTop2 = {c + 30, l + 4};
  enemy2 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy2, MidTop2);

  printf("ＡＤ:%3.0f   ＡＰ:%3.0f", (lsenemy + 1)->AD, (lsenemy + 1)->AP);

  COORD MidTop3 = {c + 30, l + 5};
  enemy2 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy2, MidTop3);

  printf("ＤＫ:%3.0f   ＭＫ:%3.0f", (lsenemy + 1)->DK, (lsenemy + 1)->MK);

  COORD MidTop4 = {c + 30, l + 6};
  enemy2 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy2, MidTop4);

  printf("ｓｐ:%g", (lsenemy + 1)->speet);

  if ((lsenemy + 1)->HP <= 0)
  {
    COORD live2 = {c + 40, l + 6};
    enemy2 = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleCursorPosition(enemy2, live2);

    printf("已阵亡");
  }

  HANDLE enemy3;
  COORD RightTop = {c + 61, l + 2};
  enemy3 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy3, RightTop); //移动光标位置到上中

  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf("%s(3)\n", (lsenemy + 2)->name);
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);

  COORD RightTop1 = {c + 56, l + 3};
  enemy3 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy3, RightTop1);

  printf("ＨＰ:%3.0f　 ＭＰ:%3.0f", (lsenemy + 2)->HP, (lsenemy + 2)->MP);

  COORD RightTop2 = {c + 56, l + 4};
  enemy3 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy3, RightTop2);

  printf("ＡＤ:%3.0f   ＡＰ:%3.0f", (lsenemy + 2)->AD, (lsenemy + 2)->AP);

  COORD RightTop3 = {c + 56, l + 5};
  enemy3 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy3, RightTop3);

  printf("ＤＫ:%3.0f   ＭＫ:%3.0f", (lsenemy + 2)->DK, (lsenemy + 2)->MK);

  COORD RightTop4 = {c + 56, l + 6};
  enemy3 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(enemy3, RightTop4);

  printf("ｓｐ:%g", (lsenemy + 2)->speet);

  if ((lsenemy + 2)->HP <= 0)
  {
    COORD live3 = {c + 66, l + 6};
    enemy3 = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleCursorPosition(enemy3, live3);

    printf("已阵亡");
  }
}

void allylook()
{ //显示己方数据
  int c = 0, l = 0;

  HANDLE ally1;
  COORD LiftUnder = {c + 9, l + 11};
  ally1 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally1, LiftUnder); //移动光标位置到左上

  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_BLUE | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf("%s(4)\n", (lsally + 1)->Name);
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);

  COORD LiftUnder1 = {c + 4, l + 12};
  ally1 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally1, LiftUnder1);

  printf("ＨＰ:%3.0f 　ＭＰ:%3.0f", (lsally + 1)->HP, (lsally + 1)->MP);

  COORD LiftUnder2 = {c + 4, l + 13};
  ally1 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally1, LiftUnder2);

  printf("ＡＤ:%3.0f   ＡＰ:%3.0f", (lsally + 1)->AD, (lsally + 1)->AP);

  COORD LiftUnder3 = {c + 4, l + 14};
  ally1 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally1, LiftUnder3);

  printf("ＤＫ:%3.0f   ＭＫ:%3.0f", (lsally + 1)->DK, (lsally + 1)->MK);

  COORD LiftUnder4 = {c + 4, l + 15};
  ally1 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally1, LiftUnder4);

  printf("ｓｐ:%g", (lsally + 1)->speet);

  if ((lsally + 1)->HP <= 0)
  {
    COORD live1 = {c + 14, l + 15};
    ally1 = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleCursorPosition(ally1, live1);

    printf("已阵亡");
  }

  HANDLE ally2;
  COORD MidUnder = {c + 35, l + 11};
  ally2 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally2, MidUnder); //移动光标位置到左上

  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_BLUE | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf("%s(5)\n", (lsally + 2)->Name);
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);

  COORD MidUnder1 = {c + 30, l + 12};
  ally2 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally2, MidUnder1);

  printf("ＨＰ:%3.0f　 ＭＰ:%3.0f", (lsally + 2)->HP, (lsally + 2)->MP);

  COORD MidUnder2 = {c + 30, l + 13};
  ally2 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally2, MidUnder2);

  printf("ＡＤ:%3.0f   ＡＰ:%3.0f", (lsally + 2)->AD, (lsally + 2)->AP);

  COORD MidUnder3 = {c + 30, l + 14};
  ally2 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally2, MidUnder3);

  printf("ＤＫ:%3.0f   ＭＫ:%3.0f", (lsally + 2)->DK, (lsally + 2)->MK);

  COORD MidUnder4 = {c + 30, l + 15};
  ally2 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally2, MidUnder4);

  printf("ｓｐ:%g", (lsally + 2)->speet);

  if ((lsally + 2)->HP <= 0)
  {
    COORD live2 = {c + 40, l + 15};
    ally2 = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleCursorPosition(ally2, live2);

    printf("已阵亡");
  }

  HANDLE ally3;
  COORD RightUnder = {c + 61, l + 11};
  ally3 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally3, RightUnder); //移动光标位置到左上

  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_BLUE | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf("%s(6)\n", (lsally + 3)->Name);
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);

  COORD RightUnder1 = {c + 56, l + 12};
  ally3 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally3, RightUnder1);

  printf("ＨＰ:%3.0f　 ＭＰ:%3.0f", (lsally + 3)->HP, (lsally + 3)->MP);

  COORD RightUnder2 = {c + 56, l + 13};
  ally3 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally3, RightUnder2);

  printf("ＡＤ:%3.0f   ＡＰ:%3.0f", (lsally + 3)->AD, (lsally + 3)->AP);

  COORD RightUnder3 = {c + 56, l + 14};
  ally3 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally3, RightUnder3);

  printf("ＤＫ:%3.0f   ＭＫ:%3.0f", (lsally + 3)->DK, (lsally + 3)->MK);

  COORD RightUnder4 = {c + 56, l + 15};
  ally3 = GetStdHandle(STD_OUTPUT_HANDLE);
  SetConsoleCursorPosition(ally3, RightUnder4);

  printf("ｓｐ:%g\n", (lsally + 3)->speet);

  if ((lsally + 3)->HP <= 0)
  {
    COORD live3 = {c + 66, l + 15};
    ally3 = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleCursorPosition(ally3, live3);

    printf("已阵亡");
  }
}

void selecthero()
{ //选择出战英雄
  int a, b, c;
  printf("\n 选择你想要出战的三个角色（可重复）......\n\n");
  for (int i = 0; i < N; i++)
  {
    printf("\tNO.%-2d         %s\n\n", i + 1, (new1 + i)->HeroName);
  }
  printf("\n 请选择第一个英雄：");
  scanf("%d", &a);
  printf("\n 请选择第二个英雄：");
  scanf("%d", &b);
  printf("\n 请选择第三个英雄：");
  scanf("%d", &c);
  hero1 = a;
  hero2 = b;
  hero3 = c;

  strcpy((lsally + 1)->Name, (new1 + a - 1)->HeroName);
  strcpy((lsally + 2)->Name, (new1 + b - 1)->HeroName);
  strcpy((lsally + 3)->Name, (new1 + c - 1)->HeroName);

  (lsally + 1)->HP = (new1 + a - 1)->HP; //将基础数据传入临时数据组
  (lsally + 2)->HP = (new1 + b - 1)->HP;
  (lsally + 3)->HP = (new1 + c - 1)->HP;

  (lsally + 1)->MP = (new1 + a - 1)->MP;
  (lsally + 2)->MP = (new1 + b - 1)->MP;
  (lsally + 3)->MP = (new1 + c - 1)->MP;

  (lsally + 1)->AD = (new1 + a - 1)->AD;
  (lsally + 2)->AD = (new1 + b - 1)->AD;
  (lsally + 3)->AD = (new1 + c - 1)->AD;

  (lsally + 1)->AP = (new1 + a - 1)->AP;
  (lsally + 2)->AP = (new1 + b - 1)->AP;
  (lsally + 3)->AP = (new1 + c - 1)->AP;

  (lsally + 1)->DK = (new1 + a - 1)->DK;
  (lsally + 2)->DK = (new1 + b - 1)->DK;
  (lsally + 3)->DK = (new1 + c - 1)->DK;

  (lsally + 1)->MK = (new1 + a - 1)->MK;
  (lsally + 2)->MK = (new1 + b - 1)->MK;
  (lsally + 3)->MK = (new1 + c - 1)->MK;

  (lsally + 1)->speet = (new1 + a - 1)->speet;
  (lsally + 2)->speet = (new1 + b - 1)->speet;
  (lsally + 3)->speet = (new1 + c - 1)->speet;

  hero1s = (new1 + a - 1)->speet;
  hero2s = (new1 + b - 1)->speet;
  hero3s = (new1 + c - 1)->speet;

  printf("\n 选择完毕！\n");
  printf("\n　　　%s　　%s　　%s\n\n", (lsally + 1)->Name, (lsally + 2)->Name, (lsally + 3)->Name);
  printf(" 准备好进入挑战！\n");
  system("pause");
}

void selectclass()
{ //选择关卡
  int a = 0;
  system("cls");
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED); //白底绿字
  printf("*********************选择关卡*********************\n\n");
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf("\t\t输入其它字符退出......\n");
  printf("\n\t\t      第一关");
  printf("\n\n\t\t      第二关");
  printf("\n\n\t\t      第三关");
  printf("\n\n\t\t      第四关");
  printf("\n\n\t\t      第五关");
  printf("\n\n\t\t      第六关");
  printf("\n\n\t\t      第七关");
  printf("\n\n\t\t      第八关");
  printf("\n\n\t\t      第九关");
  printf("\n\n\t\t      第十关");
  printf("\n\n\t\t      第11关\n\n");
  printf("\t\t      请选择：");
  fflush(stdin);
  scanf("%d", &a);
  getchar();
  system("mode con: cols=80 lines=40");
  switch (a)
  {
  case 1:
  {
    strcpy((lsenemy + 0)->name, (enemy + 0)->enemyname);
    (lsenemy + 0)->HP = (enemy + 0)->HP;
    (lsenemy + 0)->MP = (enemy + 0)->MP;
    (lsenemy + 0)->AD = (enemy + 0)->AD;
    (lsenemy + 0)->AP = (enemy + 0)->AP;
    (lsenemy + 0)->DK = (enemy + 0)->DK;
    (lsenemy + 0)->MK = (enemy + 0)->MK;
    (lsenemy + 0)->speet = (enemy + 0)->speet;

    strcpy((lsenemy + 1)->name, (enemy + 0)->enemyname);
    (lsenemy + 1)->HP = (enemy + 0)->HP;
    (lsenemy + 1)->MP = (enemy + 0)->MP;
    (lsenemy + 1)->AD = (enemy + 0)->AD;
    (lsenemy + 1)->AP = (enemy + 0)->AP;
    (lsenemy + 1)->DK = (enemy + 0)->DK;
    (lsenemy + 1)->MK = (enemy + 0)->MK;
    (lsenemy + 1)->speet = (enemy + 0)->speet;

    strcpy((lsenemy + 2)->name, (enemy + 0)->enemyname);
    (lsenemy + 2)->HP = (enemy + 0)->HP;
    (lsenemy + 2)->MP = (enemy + 0)->MP;
    (lsenemy + 2)->AD = (enemy + 0)->AD;
    (lsenemy + 2)->AP = (enemy + 0)->AP;
    (lsenemy + 2)->DK = (enemy + 0)->DK;
    (lsenemy + 2)->MK = (enemy + 0)->MK;
    (lsenemy + 2)->speet = (enemy + 0)->speet;

    enemy1s = (enemy + 0)->speet;
    enemy2s = (enemy + 0)->speet;
    enemy3s = (enemy + 0)->speet;
    while (1)
    {
      Class(a);
      if ((lsenemy + 0)->HP <= 0 && (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0)
      {
        printf("哦呦！你赢了！");
        play.victory++;
        play.Class = 2;
        play.money += 50;
        system("pause");
        break;
      }
      if ((lsally + 1)->HP <= 0 && (lsally + 2)->HP <= 0 && (lsally + 3)->HP <= 0)
      {
        printf("啊呀！你输了！");
        play.defeat++;
        system("pause");
        break;
      }
      SP();
    }
    break;
  }
  case 2:
  {
    if (play.Class < 2)
    {
      printf(" 闯过前面的关卡再来。\n");
      break;
    }
    strcpy((lsenemy + 0)->name, (enemy + 0)->enemyname);
    (lsenemy + 0)->HP = (enemy + 0)->HP;
    (lsenemy + 0)->MP = (enemy + 0)->MP;
    (lsenemy + 0)->AD = (enemy + 0)->AD;
    (lsenemy + 0)->AP = (enemy + 0)->AP;
    (lsenemy + 0)->DK = (enemy + 0)->DK;
    (lsenemy + 0)->MK = (enemy + 0)->MK;
    (lsenemy + 0)->speet = (enemy + 0)->speet;

    strcpy((lsenemy + 1)->name, (enemy + 1)->enemyname);
    (lsenemy + 1)->HP = (enemy + 1)->HP;
    (lsenemy + 1)->MP = (enemy + 1)->MP;
    (lsenemy + 1)->AD = (enemy + 1)->AD;
    (lsenemy + 1)->AP = (enemy + 1)->AP;
    (lsenemy + 1)->DK = (enemy + 1)->DK;
    (lsenemy + 1)->MK = (enemy + 1)->MK;
    (lsenemy + 1)->speet = (enemy + 1)->speet;

    strcpy((lsenemy + 2)->name, (enemy + 0)->enemyname);
    (lsenemy + 2)->HP = (enemy + 0)->HP;
    (lsenemy + 2)->MP = (enemy + 0)->MP;
    (lsenemy + 2)->AD = (enemy + 0)->AD;
    (lsenemy + 2)->AP = (enemy + 0)->AP;
    (lsenemy + 2)->DK = (enemy + 0)->DK;
    (lsenemy + 2)->MK = (enemy + 0)->MK;
    (lsenemy + 2)->speet = (enemy + 0)->speet;

    enemy1s = (enemy + 0)->speet;
    enemy2s = (enemy + 1)->speet;
    enemy3s = (enemy + 0)->speet;
    while (1)
    {
      Class(a);
      if ((lsenemy + 0)->HP <= 0 && (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0)
      {
        printf("哦呦！你赢了！");
        play.victory++;
        play.Class = 3;
        play.money += 80;
        system("pause");
        break;
      }
      if ((lsally + 1)->HP <= 0 && (lsally + 2)->HP <= 0 && (lsally + 3)->HP <= 0)
      {
        printf("啊呀！你输了！");
        play.defeat++;
        play.money += 20;
        system("pause");
        break;
      }
      SP();
    }
    break;
  }
  case 3:
  {
    if (play.Class < 3)
    {
      printf(" 闯过前面的关卡再来。\n");
      break;
    }
    strcpy((lsenemy + 0)->name, (enemy + 1)->enemyname);
    (lsenemy + 0)->HP = (enemy + 1)->HP;
    (lsenemy + 0)->MP = (enemy + 1)->MP;
    (lsenemy + 0)->AD = (enemy + 1)->AD;
    (lsenemy + 0)->AP = (enemy + 1)->AP;
    (lsenemy + 0)->DK = (enemy + 1)->DK;
    (lsenemy + 0)->MK = (enemy + 1)->MK;
    (lsenemy + 0)->speet = (enemy + 1)->speet;

    strcpy((lsenemy + 1)->name, (enemy + 2)->enemyname);
    (lsenemy + 1)->HP = (enemy + 2)->HP;
    (lsenemy + 1)->MP = (enemy + 2)->MP;
    (lsenemy + 1)->AD = (enemy + 2)->AD;
    (lsenemy + 1)->AP = (enemy + 2)->AP;
    (lsenemy + 1)->DK = (enemy + 2)->DK;
    (lsenemy + 1)->MK = (enemy + 2)->MK;
    (lsenemy + 1)->speet = (enemy + 2)->speet;

    strcpy((lsenemy + 2)->name, (enemy + 1)->enemyname);
    (lsenemy + 2)->HP = (enemy + 1)->HP;
    (lsenemy + 2)->MP = (enemy + 1)->MP;
    (lsenemy + 2)->AD = (enemy + 1)->AD;
    (lsenemy + 2)->AP = (enemy + 1)->AP;
    (lsenemy + 2)->DK = (enemy + 1)->DK;
    (lsenemy + 2)->MK = (enemy + 1)->MK;
    (lsenemy + 2)->speet = (enemy + 1)->speet;

    enemy1s = (enemy + 1)->speet;
    enemy2s = (enemy + 2)->speet;
    enemy3s = (enemy + 1)->speet;
    while (1)
    {
      Class(a);
      if ((lsenemy + 0)->HP <= 0 && (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0)
      {
        printf("哦呦！你赢了！");
        play.victory++;
        play.Class = 4;
        play.money += 110;
        system("pause");
        break;
      }
      if ((lsally + 1)->HP <= 0 && (lsally + 2)->HP <= 0 && (lsally + 3)->HP <= 0)
      {
        printf("啊呀！你输了！");
        play.defeat++;
        play.money += 30;
        system("pause");
        break;
      }
      SP();
    }
    break;
  }
  case 4:
  {
    if (play.Class < 4)
    {
      printf(" 闯过前面的关卡再来。\n");
      break;
    }
    strcpy((lsenemy + 0)->name, (enemy + 1)->enemyname);
    strcpy((lsenemy + 2)->name, (enemy + 2)->enemyname);
    strcpy((lsenemy + 1)->name, (enemy + 3)->enemyname);

    (lsenemy + 0)->HP = (enemy + 1)->HP;
    (lsenemy + 0)->MP = (enemy + 1)->MP;
    (lsenemy + 0)->AD = (enemy + 1)->AD;
    (lsenemy + 0)->AP = (enemy + 1)->AP;
    (lsenemy + 0)->DK = (enemy + 1)->DK;
    (lsenemy + 0)->MK = (enemy + 1)->MK;
    (lsenemy + 0)->speet = (enemy + 1)->speet;

    (lsenemy + 2)->HP = (enemy + 2)->HP;
    (lsenemy + 2)->MP = (enemy + 2)->MP;
    (lsenemy + 2)->AD = (enemy + 2)->AD;
    (lsenemy + 2)->AP = (enemy + 2)->AP;
    (lsenemy + 2)->DK = (enemy + 2)->DK;
    (lsenemy + 2)->MK = (enemy + 2)->MK;
    (lsenemy + 2)->speet = (enemy + 2)->speet;

    (lsenemy + 1)->HP = (enemy + 3)->HP;
    (lsenemy + 1)->MP = (enemy + 3)->MP;
    (lsenemy + 1)->AD = (enemy + 3)->AD;
    (lsenemy + 1)->AP = (enemy + 3)->AP;
    (lsenemy + 1)->DK = (enemy + 3)->DK;
    (lsenemy + 1)->MK = (enemy + 3)->MK;
    (lsenemy + 1)->speet = (enemy + 3)->speet;

    enemy1s = (enemy + 1)->speet;
    enemy2s = (enemy + 3)->speet;
    enemy3s = (enemy + 2)->speet;
    while (1)
    {
      Class(a);
      if ((lsenemy + 0)->HP <= 0 && (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0)
      {
        printf("哦呦！你赢了！");
        play.victory++;
        play.Class = 5;
        play.money += 140;
        system("pause");
        break;
      }
      if ((lsally + 1)->HP <= 0 && (lsally + 2)->HP <= 0 && (lsally + 3)->HP <= 0)
      {
        printf("啊呀！你输了！");
        play.defeat++;
        play.money += 40;
        system("pause");
        break;
      }
      SP();
    }
    break;
  }
  case 5:
  {
    if (play.Class < 5)
    {
      printf(" 闯过前面的关卡再来。\n");
      break;
    }
    strcpy((lsenemy + 0)->name, (enemy + 3)->enemyname);
    (lsenemy + 0)->HP = (enemy + 3)->HP;
    (lsenemy + 0)->MP = (enemy + 3)->MP;
    (lsenemy + 0)->AD = (enemy + 3)->AD;
    (lsenemy + 0)->AP = (enemy + 3)->AP;
    (lsenemy + 0)->DK = (enemy + 3)->DK;
    (lsenemy + 0)->MK = (enemy + 3)->MK;
    (lsenemy + 0)->speet = (enemy + 3)->speet;

    strcpy((lsenemy + 1)->name, (enemy + 4)->enemyname);
    (lsenemy + 1)->HP = (enemy + 4)->HP;
    (lsenemy + 1)->MP = (enemy + 4)->MP;
    (lsenemy + 1)->AD = (enemy + 4)->AD;
    (lsenemy + 1)->AP = (enemy + 4)->AP;
    (lsenemy + 1)->DK = (enemy + 4)->DK;
    (lsenemy + 1)->MK = (enemy + 4)->MK;
    (lsenemy + 1)->speet = (enemy + 4)->speet;

    strcpy((lsenemy + 2)->name, (enemy + 3)->enemyname);
    (lsenemy + 2)->HP = (enemy + 3)->HP;
    (lsenemy + 2)->MP = (enemy + 3)->MP;
    (lsenemy + 2)->AD = (enemy + 3)->AD;
    (lsenemy + 2)->AP = (enemy + 3)->AP;
    (lsenemy + 2)->DK = (enemy + 3)->DK;
    (lsenemy + 2)->MK = (enemy + 3)->MK;
    (lsenemy + 2)->speet = (enemy + 3)->speet;

    enemy1s = (enemy + 3)->speet;
    enemy2s = (enemy + 4)->speet;
    enemy3s = (enemy + 3)->speet;
    while (1)
    {
      Class(a);
      if ((lsenemy + 0)->HP <= 0 && (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0)
      {
        printf("哦呦！你赢了！");
        play.victory++;
        play.Class = 6;
        play.money += 170;
        system("pause");
        break;
      }
      if ((lsally + 1)->HP <= 0 && (lsally + 2)->HP <= 0 && (lsally + 3)->HP <= 0)
      {
        printf("啊呀！你输了！");
        play.defeat++;
        play.money += 50;
        system("pause");
        break;
      }
      SP();
    }
    break;
  }
  case 6:
  {
    if (play.Class < 6)
    {
      printf(" 闯过前面的关卡再来。\n");
      break;
    }
    strcpy((lsenemy + 0)->name, (enemy + 4)->enemyname);
    (lsenemy + 0)->HP = (enemy + 4)->HP;
    (lsenemy + 0)->MP = (enemy + 4)->MP;
    (lsenemy + 0)->AD = (enemy + 4)->AD;
    (lsenemy + 0)->AP = (enemy + 4)->AP;
    (lsenemy + 0)->DK = (enemy + 4)->DK;
    (lsenemy + 0)->MK = (enemy + 4)->MK;
    (lsenemy + 0)->speet = (enemy + 4)->speet;

    strcpy((lsenemy + 1)->name, (enemy + 5)->enemyname);
    (lsenemy + 1)->HP = (enemy + 5)->HP;
    (lsenemy + 1)->MP = (enemy + 5)->MP;
    (lsenemy + 1)->AD = (enemy + 5)->AD;
    (lsenemy + 1)->AP = (enemy + 5)->AP;
    (lsenemy + 1)->DK = (enemy + 5)->DK;
    (lsenemy + 1)->MK = (enemy + 5)->MK;
    (lsenemy + 1)->speet = (enemy + 5)->speet;

    strcpy((lsenemy + 2)->name, (enemy + 4)->enemyname);
    (lsenemy + 2)->HP = (enemy + 4)->HP;
    (lsenemy + 2)->MP = (enemy + 4)->MP;
    (lsenemy + 2)->AD = (enemy + 4)->AD;
    (lsenemy + 2)->AP = (enemy + 4)->AP;
    (lsenemy + 2)->DK = (enemy + 4)->DK;
    (lsenemy + 2)->MK = (enemy + 4)->MK;
    (lsenemy + 2)->speet = (enemy + 4)->speet;

    enemy1s = (enemy + 4)->speet;
    enemy2s = (enemy + 5)->speet;
    enemy3s = (enemy + 4)->speet;
    while (1)
    {
      Class(a);
      if ((lsenemy + 0)->HP <= 0 && (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0)
      {
        printf("哦呦！你赢了！");
        play.victory++;
        play.Class = 7;
        play.money += 200;
        system("pause");
        break;
      }
      if ((lsally + 1)->HP <= 0 && (lsally + 2)->HP <= 0 && (lsally + 3)->HP <= 0)
      {
        printf("啊呀！你输了！");
        play.defeat++;
        play.money += 60;
        system("pause");
        break;
      }
      SP();
    }
    break;
  }
  case 7:
  {
    if (play.Class < 7)
    {
      printf(" 闯过前面的关卡再来。\n");
      break;
    }
    strcpy((lsenemy + 0)->name, (enemy + 5)->enemyname);
    (lsenemy + 0)->HP = (enemy + 5)->HP;
    (lsenemy + 0)->MP = (enemy + 5)->MP;
    (lsenemy + 0)->AD = (enemy + 5)->AD;
    (lsenemy + 0)->AP = (enemy + 5)->AP;
    (lsenemy + 0)->DK = (enemy + 5)->DK;
    (lsenemy + 0)->MK = (enemy + 5)->MK;
    (lsenemy + 0)->speet = (enemy + 5)->speet;

    strcpy((lsenemy + 1)->name, (enemy + 6)->enemyname);
    (lsenemy + 1)->HP = (enemy + 6)->HP;
    (lsenemy + 1)->MP = (enemy + 6)->MP;
    (lsenemy + 1)->AD = (enemy + 6)->AD;
    (lsenemy + 1)->AP = (enemy + 6)->AP;
    (lsenemy + 1)->DK = (enemy + 6)->DK;
    (lsenemy + 1)->MK = (enemy + 6)->MK;
    (lsenemy + 1)->speet = (enemy + 6)->speet;

    strcpy((lsenemy + 2)->name, (enemy + 5)->enemyname);
    (lsenemy + 2)->HP = (enemy + 5)->HP;
    (lsenemy + 2)->MP = (enemy + 5)->MP;
    (lsenemy + 2)->AD = (enemy + 5)->AD;
    (lsenemy + 2)->AP = (enemy + 5)->AP;
    (lsenemy + 2)->DK = (enemy + 5)->DK;
    (lsenemy + 2)->MK = (enemy + 5)->MK;
    (lsenemy + 2)->speet = (enemy + 5)->speet;

    enemy1s = (enemy + 5)->speet;
    enemy2s = (enemy + 6)->speet;
    enemy3s = (enemy + 5)->speet;
    while (1)
    {
      Class(a);
      if ((lsenemy + 0)->HP <= 0 && (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0)
      {
        printf("哦呦！你赢了！");
        play.victory++;
        play.Class = 8;
        play.money += 230;
        system("pause");
        break;
      }
      if ((lsally + 1)->HP <= 0 && (lsally + 2)->HP <= 0 && (lsally + 3)->HP <= 0)
      {
        printf("啊呀！你输了！");
        play.defeat++;
        play.money += 70;
        system("pause");
        break;
      }
      SP();
    }
    break;
  }
  case 8:
  {
    if (play.Class < 8)
    {
      printf(" 闯过前面的关卡再来。\n");
      break;
    }
    strcpy((lsenemy + 0)->name, (enemy + 6)->enemyname);
    (lsenemy + 0)->HP = (enemy + 6)->HP;
    (lsenemy + 0)->MP = (enemy + 6)->MP;
    (lsenemy + 0)->AD = (enemy + 6)->AD;
    (lsenemy + 0)->AP = (enemy + 6)->AP;
    (lsenemy + 0)->DK = (enemy + 6)->DK;
    (lsenemy + 0)->MK = (enemy + 6)->MK;
    (lsenemy + 0)->speet = (enemy + 6)->speet;

    strcpy((lsenemy + 1)->name, (enemy + 7)->enemyname);
    (lsenemy + 1)->HP = (enemy + 7)->HP;
    (lsenemy + 1)->MP = (enemy + 7)->MP;
    (lsenemy + 1)->AD = (enemy + 7)->AD;
    (lsenemy + 1)->AP = (enemy + 7)->AP;
    (lsenemy + 1)->DK = (enemy + 7)->DK;
    (lsenemy + 1)->MK = (enemy + 7)->MK;
    (lsenemy + 1)->speet = (enemy + 7)->speet;

    strcpy((lsenemy + 2)->name, (enemy + 6)->enemyname);
    (lsenemy + 2)->HP = (enemy + 6)->HP;
    (lsenemy + 2)->MP = (enemy + 6)->MP;
    (lsenemy + 2)->AD = (enemy + 6)->AD;
    (lsenemy + 2)->AP = (enemy + 6)->AP;
    (lsenemy + 2)->DK = (enemy + 6)->DK;
    (lsenemy + 2)->MK = (enemy + 6)->MK;
    (lsenemy + 2)->speet = (enemy + 6)->speet;

    enemy1s = (enemy + 6)->speet;
    enemy2s = (enemy + 7)->speet;
    enemy3s = (enemy + 6)->speet;
    while (1)
    {
      Class(a);
      if ((lsenemy + 0)->HP <= 0 && (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0)
      {
        printf("哦呦！你赢了！");
        play.victory++;
        play.Class = 9;
        play.money += 260;
        system("pause");
        break;
      }
      if ((lsally + 1)->HP <= 0 && (lsally + 2)->HP <= 0 && (lsally + 3)->HP <= 0)
      {
        printf("啊呀！你输了！");
        play.defeat++;
        play.money += 80;
        system("pause");
        break;
      }
      SP();
    }
    break;
  }
  case 9:
  {
    if (play.Class < 9)
    {
      printf(" 闯过前面的关卡再来。\n");
      break;
    }
    strcpy((lsenemy + 0)->name, (enemy + 7)->enemyname);
    (lsenemy + 0)->HP = (enemy + 7)->HP;
    (lsenemy + 0)->MP = (enemy + 7)->MP;
    (lsenemy + 0)->AD = (enemy + 7)->AD;
    (lsenemy + 0)->AP = (enemy + 7)->AP;
    (lsenemy + 0)->DK = (enemy + 7)->DK;
    (lsenemy + 0)->MK = (enemy + 7)->MK;
    (lsenemy + 0)->speet = (enemy + 7)->speet;

    strcpy((lsenemy + 1)->name, (enemy + 8)->enemyname);
    (lsenemy + 1)->HP = (enemy + 8)->HP;
    (lsenemy + 1)->MP = (enemy + 8)->MP;
    (lsenemy + 1)->AD = (enemy + 8)->AD;
    (lsenemy + 1)->AP = (enemy + 8)->AP;
    (lsenemy + 1)->DK = (enemy + 8)->DK;
    (lsenemy + 1)->MK = (enemy + 8)->MK;
    (lsenemy + 1)->speet = (enemy + 8)->speet;

    strcpy((lsenemy + 2)->name, (enemy + 7)->enemyname);
    (lsenemy + 2)->HP = (enemy + 7)->HP;
    (lsenemy + 2)->MP = (enemy + 7)->MP;
    (lsenemy + 2)->AD = (enemy + 7)->AD;
    (lsenemy + 2)->AP = (enemy + 7)->AP;
    (lsenemy + 2)->DK = (enemy + 7)->DK;
    (lsenemy + 2)->MK = (enemy + 7)->MK;
    (lsenemy + 2)->speet = (enemy + 7)->speet;

    enemy1s = (enemy + 7)->speet;
    enemy2s = (enemy + 8)->speet;
    enemy3s = (enemy + 7)->speet;
    while (1)
    {
      Class(a);
      if ((lsenemy + 0)->HP <= 0 && (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0)
      {
        printf("哦呦！你赢了！");
        play.victory++;
        play.Class = 10;
        play.money += 290;
        system("pause");
        break;
      }
      if ((lsally + 1)->HP <= 0 && (lsally + 2)->HP <= 0 && (lsally + 3)->HP <= 0)
      {
        printf("啊呀！你输了！");
        play.defeat++;
        play.money += 90;
        system("pause");
        break;
      }
      SP();
    }
    break;
  }
  case 10:
  {
    if (play.Class < 10)
    {
      printf(" 闯过前面的关卡再来。\n");
      break;
    }
    strcpy((lsenemy + 0)->name, (enemy + 7)->enemyname);
    (lsenemy + 0)->HP = (enemy + 7)->HP;
    (lsenemy + 0)->MP = (enemy + 7)->MP;
    (lsenemy + 0)->AD = (enemy + 7)->AD;
    (lsenemy + 0)->AP = (enemy + 7)->AP;
    (lsenemy + 0)->DK = (enemy + 7)->DK;
    (lsenemy + 0)->MK = (enemy + 7)->MK;
    (lsenemy + 0)->speet = (enemy + 7)->speet;

    strcpy((lsenemy + 1)->name, (enemy + 9)->enemyname);
    (lsenemy + 1)->HP = (enemy + 9)->HP;
    (lsenemy + 1)->MP = (enemy + 9)->MP;
    (lsenemy + 1)->AD = (enemy + 9)->AD;
    (lsenemy + 1)->AP = (enemy + 9)->AP;
    (lsenemy + 1)->DK = (enemy + 9)->DK;
    (lsenemy + 1)->MK = (enemy + 9)->MK;
    (lsenemy + 1)->speet = (enemy + 9)->speet;

    strcpy((lsenemy + 2)->name, (enemy + 8)->enemyname);
    (lsenemy + 2)->HP = (enemy + 8)->HP;
    (lsenemy + 2)->MP = (enemy + 8)->MP;
    (lsenemy + 2)->AD = (enemy + 8)->AD;
    (lsenemy + 2)->AP = (enemy + 8)->AP;
    (lsenemy + 2)->DK = (enemy + 8)->DK;
    (lsenemy + 2)->MK = (enemy + 8)->MK;
    (lsenemy + 2)->speet = (enemy + 8)->speet;

    enemy1s = (enemy + 7)->speet;
    enemy2s = (enemy + 9)->speet;
    enemy3s = (enemy + 8)->speet;
    while (1)
    {
      Class(a);
      if ((lsenemy + 0)->HP <= 0 && (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0)
      {
        printf("哦呦！你赢了！");
        play.victory++;
        play.Class = 11;
        play.money += 320;
        system("pause");
        break;
      }
      if ((lsally + 1)->HP <= 0 && (lsally + 2)->HP <= 0 && (lsally + 3)->HP <= 0)
      {
        printf("啊呀！你输了！");
        play.defeat++;
        play.money += 100;
        system("pause");
        break;
      }
      SP();
    }
    break;
  }
  case 11:
  {
    if (play.Class < 11)
    {
      printf(" 闯过前面的关卡再来。\n");
      break;
    }
    strcpy((lsenemy + 0)->name, (enemy + 8)->enemyname);
    strcpy((lsenemy + 1)->name, (enemy + 10)->enemyname);
    strcpy((lsenemy + 2)->name, (enemy + 9)->enemyname);

    (lsenemy + 0)->HP = (enemy + 8)->HP;
    (lsenemy + 0)->MP = (enemy + 8)->MP;
    (lsenemy + 0)->AD = (enemy + 8)->AD;
    (lsenemy + 0)->AP = (enemy + 8)->AP;
    (lsenemy + 0)->DK = (enemy + 8)->DK;
    (lsenemy + 0)->MK = (enemy + 8)->MK;
    (lsenemy + 0)->speet = (enemy + 8)->speet;

    (lsenemy + 1)->HP = (enemy + 10)->HP;
    (lsenemy + 1)->MP = (enemy + 10)->MP;
    (lsenemy + 1)->AD = (enemy + 10)->AD;
    (lsenemy + 1)->AP = (enemy + 10)->AP;
    (lsenemy + 1)->DK = (enemy + 10)->DK;
    (lsenemy + 1)->MK = (enemy + 10)->MK;
    (lsenemy + 1)->speet = (enemy + 10)->speet;

    (lsenemy + 2)->HP = (enemy + 9)->HP;
    (lsenemy + 2)->MP = (enemy + 9)->MP;
    (lsenemy + 2)->AD = (enemy + 9)->AD;
    (lsenemy + 2)->AP = (enemy + 9)->AP;
    (lsenemy + 2)->DK = (enemy + 9)->DK;
    (lsenemy + 2)->MK = (enemy + 9)->MK;
    (lsenemy + 2)->speet = (enemy + 9)->speet;

    enemy1s = (enemy + 8)->speet;
    enemy2s = (enemy + 10)->speet;
    enemy3s = (enemy + 9)->speet;
    while (1)
    {
      Class(a);
      if ((lsenemy + 0)->HP <= 0 && (lsenemy + 1)->HP <= 0 && (lsenemy + 2)->HP <= 0)
      {
        printf("哦呦！你赢了！");
        play.victory++;
        system("pause");
        break;
      }
      if ((lsally + 1)->HP <= 0 && (lsally + 2)->HP <= 0 && (lsally + 3)->HP <= 0)
      {
        printf("啊呀！你输了！");
        play.defeat++;
        system("pause");
        break;
      }
      SP();
    }
    break;
  }
  default:
  {
    break;
  }
  }
}

void HeroSkill(int n)
{ //显示英雄技能
  system("cls");
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  printf("*********************英雄技能*********************\n");
  SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
  switch (n)
  {
  case 1:
  {
    printf("\t\t     Warrior\n\n");
    n--;
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf(" Skill 1:\t     %s\n　　对敌方发动猛烈一击，造成（%g）点物理伤害。\n\t\t\t\tCD：2回合\n\n", (new1 + n)->Skill1, (new1 + n)->AD * 1.4);
    printf(" Skill 2:\t     %s\n　　为自己套上可以抵挡（%g）点伤害的护盾。\n\t\t\t\tCD：3回合\n\n", (new1 + n)->Skill2, (new1 + n)->DK * 0.8);
    printf(" Skill 3:\t     %s\n　　斩杀低生命值的敌方，可造成（%g）点魔法伤害。\n　　自己每损失5点HP，这个技能伤害+1。\n\t\t\t\tCD：3回合\n\n", (new1 + n)->Skill3, (new1 + n)->MK);
    system("pause");
    break;
  }
  case 2:
  {
    printf("\t\t     Master\n\n");
    n--;
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf(" Skill 1:\t     %s\n　　使用魔法引发爆炸，造成（%g）点魔法伤害。\n\t\t\t\tCD：2回合\n\n", (new1 + n)->Skill1, (new1 + n)->AP * 1.3);
    printf(" Skill 2:\t     %s\n　　对所有敌方造成（%g）点魔法伤害。\n\t\t\t\tCD：2回合\n\n", (new1 + n)->Skill2, (new1 + n)->AP * 0.8);
    printf(" Skill 3:\t     %s\n　　当敌方只剩一人时，则造成（%g）点魔法伤害。\n　　否则其回复（%g）点HP、MP。\n\t\t\t\tCD：3回合\n\n", (new1 + n)->Skill3, (new1 + n)->AP * 2, (new1 + n)->HP * 0.4);
    system("pause");
    break;
  }
  case 3:
  {
    printf("\t\t     Assassin\n\n");
    n--;
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf(" Skill 1:\t     %s\n　　被动：有（%g）%％的概率使普通攻击打出（%g）点\n　　额外伤害。\n\n", (new1 + n)->Skill1, (new1 + n)->AD * 3, (new1 + n)->AD * 0.35);
    printf(" Skill 2:\t     %s\n　　被动：攻击敌方可以使敌方中毒，让其每回合受到\n　　（%g）点真实伤害。\n\n", (new1 + n)->Skill2, (new1 + n)->AD * 0.3);
    printf(" Skill 3:\t     %s\n　　被动：精通刺杀之道，有（%g）%％的概率将\n　　HP<=20的敌方直接秒杀！\n\n", (new1 + n)->Skill3, (new1 + n)->speet * 3);
    system("pause");
    break;
  }
  default:
  {
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    break;
  }
  }
}

void select(int n)
{ //菜单选项
  switch (n)
  {
  case 1:
  {
    system("cls");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED); //白底绿字
    printf("*********************挑战关卡*********************\n");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    if (play.over == 0)
    {
      printf(" 挑战者你叫什么名字:");
      scanf("%s", &play.Name);
      play.over = 1;
    }
    selecthero();
    selectclass();
    system("cls");
    fflush(stdin);
    break;
  }
  case 2:
  {
    system("cls");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf("*********************玩家信息*********************\n\n");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED); //白底黑字
    printf(" 玩家ID                %s\n\n", play.Name);
    printf(" 金币                  %d\n\n", play.money);
    printf(" 段位                  %s\n\n", play.rank);
    printf(" 胜场                  %d\n\n", play.victory);
    printf(" 负场                  %d\n\n", play.defeat);
    system("pause");
    system("cls");
    break;
  }
  case 3:
  {
    system("mode con: cols=50 lines=42");
    system("cls");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf("*********************英雄总览*********************\n");
    for (int i = 0; i < N; i++)
    {
      SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
      printf(" NO.%-2d                 %s\n", (new1 + i)->num, (new1 + i)->HeroName);
      SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
      printf(" ＨＰ                    %g\n", (new1 + i)->HP);
      printf(" ＭＰ                    %g\n", (new1 + i)->MP);
      printf(" ＡＤ                    %g\n", (new1 + i)->AD);
      printf(" ＡＰ                    %g\n", (new1 + i)->AP);
      printf(" ＤＫ                    %g\n", (new1 + i)->DK);
      printf(" ＭＫ                    %g\n", (new1 + i)->MK);
      printf(" ＳＰ                    %.2f\n", (new1 + i)->speet);
      SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_BLUE | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
      printf(" SKILL 1               %s\n", (new1 + i)->Skill1);
      printf(" SKILL 2               %s\n", (new1 + i)->Skill2);
      printf(" SKILL 3               %s\n\n\n", (new1 + i)->Skill3);
    }
    system("pause");
    system("cls");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    break;
  }
  /*{
            system("mode con: cols=50 lines=42");
			system("cls");
			SetConsoleTextAttribute(handle,BACKGROUND_INTENSITY|FOREGROUND_GREEN|BACKGROUND_GREEN|BACKGROUND_BLUE|BACKGROUND_RED);
			printf("*********************敌人数据*********************\n");
			for (int i=0;i<11;i++){
				SetConsoleTextAttribute(handle,BACKGROUND_INTENSITY|FOREGROUND_RED|BACKGROUND_GREEN|BACKGROUND_BLUE|BACKGROUND_RED);
				printf(" NO.%-2d                 %s\n",(enemy+i)->num,(enemy+i)->enemyname);
				SetConsoleTextAttribute(handle,BACKGROUND_INTENSITY|BACKGROUND_GREEN|BACKGROUND_BLUE|BACKGROUND_RED);
				printf(" ＨＰ                    %g\n",(enemy+i)->HP);
				printf(" ＭＰ                    %g\n",(enemy+i)->MP);
				printf(" ＡＤ                    %g\n",(enemy+i)->AD);
				printf(" ＡＰ                    %g\n",(enemy+i)->AP);
				printf(" ＤＫ                    %g\n",(enemy+i)->DK);
				printf(" ＭＫ                    %g\n",(enemy+i)->MK);
				printf(" ＳＰ                    %.2f\n",(enemy+i)->speet);
			}
			system("pause");
			system("cls");
			SetConsoleTextAttribute(handle,BACKGROUND_INTENSITY|BACKGROUND_GREEN|BACKGROUND_BLUE|BACKGROUND_RED);
			break;
		} 
		{
			int n;
			system("cls");
			SetConsoleTextAttribute(handle,BACKGROUND_INTENSITY|FOREGROUND_GREEN|BACKGROUND_GREEN|BACKGROUND_BLUE|BACKGROUND_RED);
			printf("*********************英雄技能*********************\n");
			SetConsoleTextAttribute(handle,BACKGROUND_INTENSITY|BACKGROUND_GREEN|BACKGROUND_BLUE|BACKGROUND_RED);
			printf(" 选择你要查看的英雄\n\n");
			for (int i=0;i<N;i++){
				printf("      NO.%-2d          %s\n",i+1,(new1+i)->HeroName);
			}
			printf(" 请选择:");
			scanf("%d",&n);
			getchar();
			HeroSkill(n);
			system("cls");
			break;
		}*/
  case 4:
  {
    system("cls");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf("*********************游戏教程*********************\n");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf(" 啦啦啦，欢迎来到ChenShiAi的游戏小教程\n");
    system("pause");
    system("cls");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf("*********************游戏教程*********************\n");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf(" 先来认识以下几个英文简称。\n\n");
    printf(" HP  角色的生命值，当变成0时，角色死亡。\n\n");
    printf(" MP  角色的法力值，施放技能消耗法力，每次出手可回复2点。\n\n");
    printf(" AD  角色的攻击力，普通攻击能够造成的物理伤害。\n\n");
    printf(" AP  角色的法术强度，可以提高技能的效果。\n\n");
    printf(" DK  角色的防御力，可以抵消一部分的物理伤害。\n\n");
    printf(" MK  角色的抗性，可以抵消一部分的魔法伤害。\n\n");
    printf(" SP  角色出手的速度，速度越快的越先出手。\n\n");
    printf(" CD  技能使用一次后要等待一定的回合后才可以使用。\n\n");
    printf("     技能名字后面的数字表示所需的MP消耗。\n\n");
    system("pause");
    system("cls");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf("*********************游戏教程*********************\n");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf(" 　　每当一个角色出手时，你都有五种选择，攻击、施\n 放技能1 2 3和直接跳过\n\n");
    printf(" 伤害计算公式如下：\n\n");
    printf(" 　　物理伤害：HURT=AD-DK/(DK+10)\n　　 魔法伤害亦如此。\n\n");
    system("pause");
    system("cls");
    break;
  }
  case 5:
  {
    system("cls");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf("*********************删除存档*********************\n");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf(" 暂未实装！");
    system("pause");
    system("cls");
    break;
  }
  case 6:
  {
    system("cls");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | FOREGROUND_GREEN | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf("*********************制作人员*********************\n");
    SetConsoleTextAttribute(handle, BACKGROUND_INTENSITY | BACKGROUND_GREEN | BACKGROUND_BLUE | BACKGROUND_RED);
    printf("\t\t  只有CHENSHIAI\n\n");
    system("pause");
    system("cls");
    break;
  }
  case 7:
  {
    exit(0);
    break;
  }
  default:
  {
    break;
  }
  }
}

int main()
{
  int n;
  system("color f0");
  while (1)
  {
    menu();
    scanf("%d", &n);
    getchar();
    select(n);
  }
  return 0;
}
