pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Weltkarte;

package KartenkoordinateXAchseBerechnenLogik is
   
   type WelcheVerschiebungXAchseArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.Kartenform_X_Einstellbar_Enum;
   WelcheVerschiebungXAchse : WelcheVerschiebungXAchseArray;
   
   

   function KartenkoordinateXAchseBerechnen
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
           
       Post => (
                  KartenkoordinateXAchseBerechnen'Result <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );
   
   function XAchseVerschieben
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
           
       Post => (
                  XAchseVerschieben'Result <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );
   
private
   
   -- Achsenverschiebung einstellbar machen? äöü
   HalberWert : constant Float := 0.50;
   
   type ÜberhangArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of Integer;
   ÜberhangXAchse : ÜberhangArray;
   
   
   
   function ÜbergangWesten
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
           
       Post => (
                  ÜbergangWesten'Result <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );
   
   function ÜbergangWestenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
           
       Post => (
                  ÜbergangWestenNormal'Result <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );
   
   function ÜbergangWestenRückwärts
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
           
       Post => (
                  ÜbergangWestenRückwärts'Result <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );
   
   function ÜbergangOsten
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
           
       Post => (
                  ÜbergangOsten'Result <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );
   
   function ÜbergangOstenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
           
       Post => (
                  ÜbergangOstenNormal'Result <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );
   
   function ÜbergangOstenRückwärts
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
           
       Post => (
                  ÜbergangOstenRückwärts'Result <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );

end KartenkoordinateXAchseBerechnenLogik;
