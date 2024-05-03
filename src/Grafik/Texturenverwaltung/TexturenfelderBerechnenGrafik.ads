with Sf.System.Vector2;

with KartengrundDatentypen;

package TexturenfelderBerechnenGrafik is

   procedure TexturenfelderBerechnen;
   
   
   
   function BasisgrundFelderwerte
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
     return Sf.System.Vector2.sfVector2u;
   
private
   
   FeldanzahlBasisgrund : constant Sf.System.Vector2.sfVector2u := (10, 10);
   
   Feldauflösung : Sf.System.Vector2.sfVector2u;
   Texturenauflösung : Sf.System.Vector2.sfVector2u;
   AktuelleFeldposition : Sf.System.Vector2.sfVector2u;
   
   type TestArray is array (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of Sf.System.Vector2.sfVector2u;
   Test : TestArray;
   
   procedure BasisgrundBerechnen;
   
end TexturenfelderBerechnenGrafik;
