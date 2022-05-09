pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body ForschungAllgemeinKonsole is
   
   function ForschungAuswahlKonsole
     return EinheitenDatentypen.ForschungIDMitNullWert
   is begin
            
      AuswahlSchleife:
      loop
         
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Oben_Enum =>
               if
                 AktuelleAuswahl = TextAnzeigeKonsole.AllgemeineAnzeigeText'First
               then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when TastenbelegungDatentypen.Unten_Enum =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := TextAnzeigeKonsole.AllgemeineAnzeigeText'First;
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               return EinheitenDatentypen.ForschungIDMitNullWert (ForschungText (AktuelleAuswahl).Nummer);

            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               return 0;
                     
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
            
   end ForschungAuswahlKonsole;

end ForschungAllgemeinKonsole;
