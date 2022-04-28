pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;

with Karten;

package KartengeneratorRessourcenUnterflaecheLand is

   procedure KartengeneratorRessourcenUnterflächeLand
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

private

   ZusatzberechnungenRessource : KartengrundDatentypen.Karten_Ressourcen_Enum;
   WelcheRessource : KartengrundDatentypen.Karten_Ressourcen_Enum;

   type KartenressourceWahrscheinlichkeitArray is array (KartengrundDatentypen.Karten_Ressourcen_Land'Range) of Float;
   KartenressourceWahrscheinlichkeit : KartenressourceWahrscheinlichkeitArray := (
                                                                                  KartengrundDatentypen.Kohle_Enum              => 0.02,
                                                                                  KartengrundDatentypen.Eisen_Enum              => 0.02,
                                                                                  KartengrundDatentypen.Öl_Enum                 => 0.02,
                                                                                  KartengrundDatentypen.Hochwertiger_Boden_Enum => 0.02,
                                                                                  KartengrundDatentypen.Gold_Enum               => 0.02
                                                                                 );
   GezogeneZahlen : KartenressourceWahrscheinlichkeitArray;

   type WelcheMöglichkeitenArray is array (KartenressourceWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;



   function RessourceZusatzberechnungen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Enum)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   function ZusatzberechnungKohle
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Land)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   function ZusatzberechnungEisen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Land)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   function ZusatzberechnungÖl
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Land)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   function ZusatzberechnungHochwertigerBoden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Land)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   function ZusatzberechnungGold
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Land)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

end KartengeneratorRessourcenUnterflaecheLand;
