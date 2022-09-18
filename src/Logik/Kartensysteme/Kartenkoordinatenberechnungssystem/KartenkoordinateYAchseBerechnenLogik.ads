pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Weltkarte;

package KartenkoordinateYAchseBerechnenLogik is
   
   type WelcheVerschiebungYAchseArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.Kartenform_Y_Einstellbar_Enum;
   WelcheVerschiebungYAchse : WelcheVerschiebungYAchseArray;

   function KartenkoordinateYAchseBerechnen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
              ),
           
       Post => (
                  KartenkoordinateYAchseBerechnen'Result <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               );
   
   function YAchseVerschieben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
              ),
           
       Post => (
                  YAchseVerschieben'Result <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               );
   
private
   
   -- Achsenverschiebung einstellbar machen? äöü
   HalberWert : constant Float := 0.50;
   
   type ÜberhangArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of Integer;
   ÜberhangYAchse : ÜberhangArray;
   
   function ÜbergangNorden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
              ),
           
       Post => (
                  ÜbergangNorden'Result <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               );
   
   function ÜbergangNordenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
              ),
           
       Post => (
                  ÜbergangNordenNormal'Result <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               );
   
   function ÜbergangNordenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
              ),
           
       Post => (
                  ÜbergangNordenRückwärts'Result <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               );
   
   function ÜbergangSüden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
              ),
           
       Post => (
                  ÜbergangSüden'Result <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               );
   
   function ÜbergangSüdenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      ArrayPositionExtern : in KartenDatentypen.EbeneVorhanden;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
              ),
           
       Post => (
                  ÜbergangSüdenNormal'Result <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               );
   
   function ÜbergangSüdenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 YAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
              ),
           
       Post => (
                  ÜbergangSüdenRückwärts'Result <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               );

end KartenkoordinateYAchseBerechnenLogik;
