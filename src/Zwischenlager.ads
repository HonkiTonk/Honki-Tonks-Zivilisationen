if
  LeseOptionen.Sprache = TextKonstanten.LeerUnboundedString
then
   case
     EinlesenSpracheLogik.EinlesenSprache
   is
      when True =>
         SpracheAuswählenSchleife:
         loop

            GewählteSprache := SprachauswahlLogik.AuswahlSprache;

            if
              GewählteSprache = TextKonstanten.LeerUnboundedString
            then
               null;

            else
               exit SpracheAuswählenSchleife;
            end if;

         end loop SpracheAuswählenSchleife;

         SchreibeOptionen.Sprache (SpracheExtern => GewählteSprache);
         SchreibeGrafiktask.SchriftartSetzen (JaNeinExtern => True);
         SchreibenEinstellungenLogik.Nutzereinstellungen;

      when False =>
         MeldungssystemHTB1.Logik (MeldungExtern => "EinlesenLogik.EinlesenMitAnzeige: Sprachen nicht gefunden");
         return;
   end case;

else
   null;
end if;




VerboteneNamenSchleife:
      for VerboteneNamenSchleifenwert in BetriebssystemKonstanten.VerboteneWindowsnamenGroß'Range loop

         if
           To_Wide_Wide_String (Source => Text)'Length < To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert))'Length
         then
            Erlaubt := True;

         elsif
           Text = BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert)
           or
             Text = BetriebssystemKonstanten.VerboteneWindowsnamenKlein (VerboteneNamenSchleifenwert)
         then
            return SystemRecordKonstanten.LeerTexteingabe;

         else
            Erlaubt := False;

            WörterSchleife:
            for WörterSchleifenwert in To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert))'Range loop

               if
                 To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert)) (WörterSchleifenwert) = Element (Source => Text,
                                                                                                                                                                     Index  => WörterSchleifenwert)
                 or
                   To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenKlein (VerboteneNamenSchleifenwert)) (WörterSchleifenwert) = Element (Source => Text,
                                                                                                                                                                       Index  => WörterSchleifenwert)
               then
                  null;

               else
                  Erlaubt := True;
                  exit WörterSchleife;
               end if;

            end loop WörterSchleife;
         end if;

         case
           Erlaubt
         is
            when True =>
               null;

            when False =>
               if
                 To_Wide_Wide_String (Source => Text)'Length < To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert))'Last + 1
               then
                  return SystemRecordKonstanten.LeerTexteingabe;

               elsif
                 BetriebssystemKonstanten.Punkt = To_Wide_Wide_String (Source => Text) (To_Wide_Wide_String (Source => BetriebssystemKonstanten.VerboteneWindowsnamenGroß (VerboteneNamenSchleifenwert))'Last + 1)
               then
                  return SystemRecordKonstanten.LeerTexteingabe;

               else
                  null;
               end if;
         end case;

      end loop VerboteneNamenSchleife;
