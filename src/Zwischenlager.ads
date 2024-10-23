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
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenLogik.EinlesenMitAnzeige: Sprachen nicht gefunden");
         return;
   end case;

else
   null;
end if;
