pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with Views;
with KartengrundDatentypen;
with InteraktionAuswahl;

with AllgemeineViewsGrafik;
with ViewsEinstellenGrafik;
with ObjekteZeichnenGrafik;
with FarbgebungGrafik;

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
      
      Grafikposition := (0.00, 0.00);
      
      -- Zu berücksichtigen, nicht alle Felder habe aktuell eine Farbe, später mal hinzufügen. äöü
      KartengrundSchleife:
      for KartengrundSchleifenwert in InteraktionAuswahl.PositionenKartengrundeditorArray'Range loop
         
         ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => Feldgröße,
                                                 PositionExtern  => Grafikposition,
                                                 FarbeExtern     => FarbgebungGrafik.FarbeKartenfeldErmitteln (GrundExtern => KartengrundSchleifenwert));
         
         InteraktionAuswahl.PositionenKartengrundeditor (KartengrundSchleifenwert) := (Grafikposition.x, Grafikposition.y, Feldgröße.x, Feldgröße.y);
         
         case
           KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Pos (KartengrundSchleifenwert) mod 6
         is
            when 0 =>
               Grafikposition.x := 0.00;
               Grafikposition.y := Grafikposition.y + Feldgröße.y;
               
            when others =>
               Grafikposition.x := Grafikposition.x + Feldgröße.x;
         end case;
                  
      end loop KartengrundSchleife;
            
   end KartengrundEditor;

end KartengrundEditorGrafik;
