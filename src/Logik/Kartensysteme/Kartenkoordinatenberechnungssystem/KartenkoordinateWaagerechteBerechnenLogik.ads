with KartenDatentypen;
with SystemDatentypen;

private with KartenartDatentypen;

private with KartenkoordinatenWerteLogik;

with LeseWeltkarteneinstellungen;

package KartenkoordinateWaagerechteBerechnenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Waagerechte;

   function KartenkoordinateWaagerechteBerechnen
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              ),
           
       Post => (
                  KartenkoordinateWaagerechteBerechnen'Result <= LeseWeltkarteneinstellungen.Waagerechte
               );
   
   function WaagerechteVerschieben
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechtePositiv
     with
       Pre => (
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              ),
           
       Post => (
                  WaagerechteVerschieben'Result <= LeseWeltkarteneinstellungen.Waagerechte
               );
   
private
      
   ÜberhangWaagerechte : KartenkoordinatenWerteLogik.ÜberhangArray;
   
   type KartenartArray is array (SystemDatentypen.Task_Enum'Range) of KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum;
   Kartenart : KartenartArray;
   
   
   
   function ÜbergangWesten
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              ),
           
       Post => (
                  ÜbergangWesten'Result <= LeseWeltkarteneinstellungen.Waagerechte
               );
   
   function ÜbergangWestenNormal
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechtePositiv
     with
       Pre => (
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              ),
           
       Post => (
                  ÜbergangWestenNormal'Result <= LeseWeltkarteneinstellungen.Waagerechte
               );
   
   function ÜbergangWestenRückwärts
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              ),
           
       Post => (
                  ÜbergangWestenRückwärts'Result <= LeseWeltkarteneinstellungen.Waagerechte
               );
   
   function ÜbergangOsten
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              ),
           
       Post => (
                  ÜbergangOsten'Result <= LeseWeltkarteneinstellungen.Waagerechte
               );
   
   function ÜbergangOstenNormal
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.WaagerechtePositiv
     with
       Pre => (
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              ),
           
       Post => (
                  ÜbergangOstenNormal'Result <= LeseWeltkarteneinstellungen.Waagerechte
               );
   
   function ÜbergangOstenRückwärts
     (WaagerechteExtern : in KartenDatentypen.WaagerechtePositiv;
      ÄnderungWaagerechteExtern : in KartenDatentypen.Waagerechte)
      return KartenDatentypen.WaagerechteNatural
     with
       Pre => (
                 WaagerechteExtern <= LeseWeltkarteneinstellungen.Waagerechte
              ),
           
       Post => (
                  ÜbergangOstenRückwärts'Result <= LeseWeltkarteneinstellungen.Waagerechte
               );

end KartenkoordinateWaagerechteBerechnenLogik;
