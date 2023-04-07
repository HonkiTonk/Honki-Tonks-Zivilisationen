with KartenDatentypen;

private with KartenartDatentypen;

private with KartenkoordinatenWerteLogik;

with LeseWeltkarteneinstellungen;

package KartenkoordinateYAchseBerechnenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   function KartenkoordinateYAchseBerechnen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  KartenkoordinateYAchseBerechnen'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function YAchseVerschieben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  YAchseVerschieben'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
private
      
   ÜberhangYAchse : KartenkoordinatenWerteLogik.ÜberhangArray;
   
   type KartenartArray is array (Boolean'Range) of KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   Kartenart : KartenartArray;
   
   
   
   function ÜbergangNorden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangNorden'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function ÜbergangNordenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangNordenNormal'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function ÜbergangNordenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangNordenRückwärts'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function ÜbergangSüden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangSüden'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function ÜbergangSüdenNormal
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld;
      LogikGrafikExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangSüdenNormal'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function ÜbergangSüdenRückwärts
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangSüdenRückwärts'Result <= LeseWeltkarteneinstellungen.YAchse
               );

end KartenkoordinateYAchseBerechnenLogik;
