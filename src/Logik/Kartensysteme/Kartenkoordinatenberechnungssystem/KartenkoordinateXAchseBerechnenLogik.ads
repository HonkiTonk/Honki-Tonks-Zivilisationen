pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with Weltkarte;

private with KartenkoordinatenWerteLogik;

package KartenkoordinateXAchseBerechnenLogik is
   pragma Elaborate_Body;

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
      
   ÜberhangXAchse : KartenkoordinatenWerteLogik.ÜberhangArray;
   
   
   
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
      return KartenDatentypen.KartenfeldNatural
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
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 XAchseExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
           
       Post => (
                  ÜbergangOstenRückwärts'Result <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );

end KartenkoordinateXAchseBerechnenLogik;
