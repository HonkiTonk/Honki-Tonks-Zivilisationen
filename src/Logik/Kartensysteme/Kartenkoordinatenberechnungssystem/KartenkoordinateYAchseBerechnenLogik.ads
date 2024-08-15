with KartenDatentypen;
with SystemDatentypen;

private with KartenartDatentypen;

private with KartenkoordinatenWerteLogik;

with LeseWeltkarteneinstellungen;

package KartenkoordinateYAchseBerechnenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;

   function KartenkoordinateYAchseBerechnen
     (YAchseExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  KartenkoordinateYAchseBerechnen'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function YAchseVerschieben
     (YAchseExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechtePositiv
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  YAchseVerschieben'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
private
      
   ÜberhangYAchse : KartenkoordinatenWerteLogik.ÜberhangArray;
   
   type KartenartArray is array (SystemDatentypen.Task_Enum'Range) of KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   Kartenart : KartenartArray;
   
   
   
   function ÜbergangNorden
     (YAchseExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangNorden'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function ÜbergangNordenNormal
     (YAchseExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechtePositiv
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangNordenNormal'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function ÜbergangNordenRückwärts
     (YAchseExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Senkrechte)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangNordenRückwärts'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function ÜbergangSüden
     (YAchseExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangSüden'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function ÜbergangSüdenNormal
     (YAchseExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechtePositiv
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangSüdenNormal'Result <= LeseWeltkarteneinstellungen.YAchse
               );
   
   function ÜbergangSüdenRückwärts
     (YAchseExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Senkrechte)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 YAchseExtern <= LeseWeltkarteneinstellungen.YAchse
              ),
           
       Post => (
                  ÜbergangSüdenRückwärts'Result <= LeseWeltkarteneinstellungen.YAchse
               );

end KartenkoordinateYAchseBerechnenLogik;
