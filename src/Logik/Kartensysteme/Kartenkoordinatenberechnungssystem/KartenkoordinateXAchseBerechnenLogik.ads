with KartenDatentypen;

private with KartenartDatentypen;

private with KartenkoordinatenWerteLogik;

with LeseWeltkarteneinstellungen;

package KartenkoordinateXAchseBerechnenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   function KartenkoordinateXAchseBerechnen
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  KartenkoordinateXAchseBerechnen'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function XAchseVerschieben
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  XAchseVerschieben'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
private
      
   ÜberhangXAchse : KartenkoordinatenWerteLogik.ÜberhangArray;
   
   type KartenartArray is array (Boolean'Range) of KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   Kartenart : KartenartArray;
   
   
   
   function ÜbergangWesten
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangWesten'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function ÜbergangWestenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangWestenNormal'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function ÜbergangWestenRückwärts
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangWestenRückwärts'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function ÜbergangOsten
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangOsten'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function ÜbergangOstenNormal
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangOstenNormal'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function ÜbergangOstenRückwärts
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangOstenRückwärts'Result <= LeseWeltkarteneinstellungen.XAchse
               );

end KartenkoordinateXAchseBerechnenLogik;
