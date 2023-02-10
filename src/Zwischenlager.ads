SpeicherdateiSchleife:
for SpeicherdateiSchleifenwert in Schleifenanfang .. SpielstandArray'Last loop

   case
     More_Entries (Search => Suche)
   is
      when False =>
         exit SpeicherdateiSchleife;

      when True =>
         Get_Next_Entry (Search          => Suche,
                         Directory_Entry => Spielstanddatei);
   end case;

   Spielstand (SpeicherdateiSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => To_Wide_Wide_String (Item => Simple_Name (Directory_Entry => Spielstanddatei)));

   case
     SpeicherdateiSchleifenwert
   is
      when SpielstandArray'Last =>
         NachGrafiktask.MehrereSeiten := True;

      when others =>
         null;
   end case;

end loop SpeicherdateiSchleife;
