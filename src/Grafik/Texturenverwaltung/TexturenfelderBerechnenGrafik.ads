with Sf.System.Vector2;
with Sf.Graphics.Rect;

with KartengrundDatentypen;

package TexturenfelderBerechnenGrafik is

   procedure TexturenfelderBerechnen;
   
   
   
   function BasisgrundFelderwerte
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
     return Sf.Graphics.Rect.sfIntRect;
   
private
   
   FeldanzahlBasisgrund : constant Sf.System.Vector2.sfVector2u := (10, 10);
   
   Feldauflösung : Sf.System.Vector2.sfVector2u;
   Texturenauflösung : Sf.System.Vector2.sfVector2u;
   AktuelleFeldposition : Sf.System.Vector2.sfVector2u;
   
   type BasisgrundArray is array (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfIntRect;
   Basisgrund : BasisgrundArray;
   
   procedure BasisgrundBerechnen;
   
end TexturenfelderBerechnenGrafik;
