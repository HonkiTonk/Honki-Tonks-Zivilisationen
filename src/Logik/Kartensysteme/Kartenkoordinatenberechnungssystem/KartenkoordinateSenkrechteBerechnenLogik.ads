with KartenDatentypen;
with SystemDatentypen;

private with KartenartDatentypen;

private with KartenkoordinatenWerteLogik;

with LeseWeltkarteneinstellungen;

package KartenkoordinateSenkrechteBerechnenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;

   function KartenkoordinateSenkrechteBerechnen
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
              ),
           
       Post => (
                  KartenkoordinateSenkrechteBerechnen'Result <= LeseWeltkarteneinstellungen.Senkrechte
               );
   
   function SenkrechteVerschieben
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechtePositiv
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
              ),
           
       Post => (
                  SenkrechteVerschieben'Result <= LeseWeltkarteneinstellungen.Senkrechte
               );
   
private
      
   ÜberhangSenkrechte : KartenkoordinatenWerteLogik.ÜberhangArray;
   
   type KartenartArray is array (SystemDatentypen.Task_Enum'Range) of KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum;
   Kartenart : KartenartArray;
   
   
   
   function ÜbergangNorden
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
              ),
           
       Post => (
                  ÜbergangNorden'Result <= LeseWeltkarteneinstellungen.Senkrechte
               );
   
   function ÜbergangNordenNormal
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechtePositiv
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
              ),
           
       Post => (
                  ÜbergangNordenNormal'Result <= LeseWeltkarteneinstellungen.Senkrechte
               );
   
   function ÜbergangNordenRückwärts
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
              ),
           
       Post => (
                  ÜbergangNordenRückwärts'Result <= LeseWeltkarteneinstellungen.Senkrechte
               );
   
   function ÜbergangSüden
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
              ),
           
       Post => (
                  ÜbergangSüden'Result <= LeseWeltkarteneinstellungen.Senkrechte
               );
   
   function ÜbergangSüdenNormal
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenDatentypen.SenkrechtePositiv
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
              ),
           
       Post => (
                  ÜbergangSüdenNormal'Result <= LeseWeltkarteneinstellungen.Senkrechte
               );
   
   function ÜbergangSüdenRückwärts
     (SenkrechteExtern : in KartenDatentypen.SenkrechtePositiv;
      ÄnderungSenkrechteExtern : in KartenDatentypen.Senkrechte)
      return KartenDatentypen.SenkrechteNatural
     with
       Pre => (
                 SenkrechteExtern <= LeseWeltkarteneinstellungen.Senkrechte
              ),
           
       Post => (
                  ÜbergangSüdenRückwärts'Result <= LeseWeltkarteneinstellungen.Senkrechte
               );

end KartenkoordinateSenkrechteBerechnenLogik;
