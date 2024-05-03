with Sf.Graphics.Texture;

with EingeleseneTexturenGrafik;

package body TexturenfelderBerechnenGrafik is

   procedure TexturenfelderBerechnen
   is begin
      
      BasisgrundBerechnen;
      
   end TexturenfelderBerechnen;
   
   
   
   procedure BasisgrundBerechnen
   is
      use type Sf.sfUint32;
   begin
            
      Texturenauflösung := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.BasisgrundGesamt);
      
      Feldauflösung := (Texturenauflösung.x / FeldanzahlBasisgrund.x, Texturenauflösung.y / FeldanzahlBasisgrund.y);
      
      AktuelleFeldposition := (0, 0);
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in TestArray'Range loop
         
         Test (BasisgrundSchleifenwert) := (0, 0);
         
         if
           AktuelleFeldposition.x >= FeldanzahlBasisgrund.x
         then
            AktuelleFeldposition.x := 0;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
            
         else
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
         end if;
         
      end loop BasisgrundSchleife;
      
   end BasisgrundBerechnen;
   
   
   
   function BasisgrundFelderwerte
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2u
   is begin
      
      return Test (BasisgrundExtern);
      
   end BasisgrundFelderwerte;

end TexturenfelderBerechnenGrafik;
