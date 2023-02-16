with Sf.Graphics.RenderWindow;

with Views;
with InteraktionAuswahl;

with EinstellungenGrafik;
with NachLogiktask;
with Vergleiche;

package body MausauswahlEditorLogik is

   function Kartengrundeditor
     return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => (Sf.sfInt32 (InteraktionAllgemein.Mausposition.x), Sf.sfInt32 (InteraktionAllgemein.Mausposition.y)),
                                                                 view         => Views.EditorenviewAccesse (1));
      
      KartengrundSchleife:
      for KartengrundSchleifenwert in InteraktionAuswahl.PositionenKartengrundeditorArray'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenKartengrundeditor (KartengrundSchleifenwert))
         is
            when True =>
               return KartengrundSchleifenwert;
               
            when False =>
               null;
         end case;
         
      end loop KartengrundSchleife;
      
      return KartengrundDatentypen.Leer_Grund_Enum;
      
   end Kartengrundeditor;

end MausauswahlEditorLogik;
