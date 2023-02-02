with GrafikDatentypen;
with Views;
with KartengrundDatentypen;
with InteraktionAuswahl;

with AllgemeineViewsGrafik;
with ViewsEinstellenGrafik;
-- with ObjekteZeichnenGrafik;

package body KartengrundEditorGrafik is

   procedure KartengrundEditor
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => "Test",
                                          HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                          SpielenamenExtern => False);
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      -- Eins und Zwei bei den Views/Anzeigebereich durch True und False ersetzen? äöü
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.EditorenviewAccesse (1),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Editorenbereich (1));
      
      Feldgröße.x := Viewfläche.x / 6.00;
      Feldgröße.y := Viewfläche.y / 5.00;
      
      Grafikposition := GrafikRecordKonstanten.Nullposition;
      
      KartengrundSchleife:
      for KartengrundSchleifenwert in InteraktionAuswahl.PositionenBasisgrundeditorArray'Range loop
         
         -- ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => Feldgröße,
         --                                         PositionExtern  => Grafikposition,
         --                                         FarbeExtern     => FarbgebungGrafik.FarbeKartenfeldErmitteln (GrundExtern => KartengrundSchleifenwert));
         
         InteraktionAuswahl.PositionenBasisgrundeditor (KartengrundSchleifenwert) := (Grafikposition.x, Grafikposition.y, Feldgröße.x, Feldgröße.y);
         
         case
           KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (KartengrundSchleifenwert) mod 6
         is
            when 0 =>
               Grafikposition.x := GrafikRecordKonstanten.Nullposition.x;
               Grafikposition.y := Grafikposition.y + Feldgröße.y;
               
            when others =>
               Grafikposition.x := Grafikposition.x + Feldgröße.x;
         end case;
                  
      end loop KartengrundSchleife;
            
   end KartengrundEditor;

end KartengrundEditorGrafik;
