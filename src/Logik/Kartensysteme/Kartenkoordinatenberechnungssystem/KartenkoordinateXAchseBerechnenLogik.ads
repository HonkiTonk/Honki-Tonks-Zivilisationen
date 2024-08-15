with KartenDatentypen;
with SystemDatentypen;

private with KartenartDatentypen;

private with KartenkoordinatenWerteLogik;

with LeseWeltkarteneinstellungen;

package KartenkoordinateXAchseBerechnenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Waagerechte;

   function KartenkoordinateXAchseBerechnen
     (XAchseExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  KartenkoordinateXAchseBerechnen'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function XAchseVerschieben
     (XAchseExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechtePositiv
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  XAchseVerschieben'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
private
      
   ÜberhangXAchse : KartenkoordinatenWerteLogik.ÜberhangArray;
   
   type KartenartArray is array (SystemDatentypen.Task_Enum'Range) of KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   Kartenart : KartenartArray;
   
   
   
   function ÜbergangWesten
     (XAchseExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangWesten'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function ÜbergangWestenNormal
     (XAchseExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechtePositiv
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangWestenNormal'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function ÜbergangWestenRückwärts
     (XAchseExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Waagerechte)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangWestenRückwärts'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function ÜbergangOsten
     (XAchseExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangOsten'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function ÜbergangOstenNormal
     (XAchseExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechtePositiv
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangOstenNormal'Result <= LeseWeltkarteneinstellungen.XAchse
               );
   
   function ÜbergangOstenRückwärts
     (XAchseExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Waagerechte)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 XAchseExtern <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                  ÜbergangOstenRückwärts'Result <= LeseWeltkarteneinstellungen.XAchse
               );

end KartenkoordinateXAchseBerechnenLogik;
