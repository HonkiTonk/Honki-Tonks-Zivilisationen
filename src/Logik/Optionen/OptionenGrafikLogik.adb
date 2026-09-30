with TextKonstantenHTSEB;
with SystemDatentypenHTSEB;

with GrafikDatentypen;
with TextnummernKonstanten;
with MenueDatentypen;
with ZeitKonstanten;
with GrafikKonstanten;
with VerzeichnisKonstanten;

with SchreibeEinstellungenGrafik;
with LeseEinstellungenGrafik;
with SchreibeLogiktask;
with LeseLogiktask;
with SchreibeGrafiktask;
with LeseGrafiktask;
with SchreibeOptionen;

with AuswahlaufteilungLogik;
with ZahleneingabeLogik;
with MeldungssystemHTSEB;
with SchreibenEinstellungenLogik;
with EinlesenTexturenLogik;
with SetauswahlLogik;
with EinlesenSetsLogik;

package body OptionenGrafikLogik is

   function OptionenGrafik
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is
      use type Sf.sfBool;
   begin
      
      EinstellungenSchreiben := False;
      EinstellungenGeändert := False;
            
      GrafikSchleife:
      loop
         
         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Grafik_Menü_Enum);
         
         case
           AuswahlWert
         is
            when Auflösung =>
               EinstellungenGeändert := AuflösungÄndern;
            
            when Vollbild =>
               VollbildFenster;
               EinstellungenGeändert := True;
               
            when Rahmenlos =>
               FensterRahmenlos;
               EinstellungenGeändert := True;
               
            when VSync =>
               SchreibeEinstellungenGrafik.VSync (AktivierenDeaktivierenExtern => not LeseEinstellungenGrafik.VSync);
               SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Bildrate_Ändern_Enum);
               
            when Bildrate =>
               EinstellungenGeändert := BildrateÄndern;
               
            when Ebenensichtbarkeit =>
               SchreibeEinstellungenGrafik.EbenenUnterhalbSichtbar;
               EinstellungenGeändert := True;
               
            when Bildratensichtbarkeit =>
               SchreibeEinstellungenGrafik.BildrateAnzeigen;
               EinstellungenGeändert := True;
               
            when Texturenwechsel =>
               EinstellungenGeändert := TexturenWechseln;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               exit GrafikSchleife;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenGrafikLogik.OptionenGrafik: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
         case
           EinstellungenGeändert
         is
            when True =>
               EinstellungenSchreiben := True;
               
            when False =>
               null;
         end case;
         
      end loop GrafikSchleife;
      
      case
        EinstellungenSchreiben
      is
         when True =>
            SchreibenEinstellungenLogik.Grafikeinstellungen;
            
         when False =>
            null;
      end case;
      
      return AuswahlWert;
      
   end OptionenGrafik;
   
   
   
   function AuflösungÄndern
     return Boolean
   is begin
      
      EingabeAuflösung := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => SystemDatentypenHTSEB.EigenesPositive (GrafikKonstanten.MinimaleAuflösungsbreite),
                                                             ZahlenMaximumExtern => SystemDatentypenHTSEB.EigenesPositive (GrafikKonstanten.MaximaleAuflösungsbreite),
                                                             WelcheFrageExtern   => TextnummernKonstanten.FrageAuflösungsbreite);
      
      case
        EingabeAuflösung.ErfolgreichAbbruch
      is
         when False =>
            return False;
            
         when True =>
            NeueAuflösung.x := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
      
            EingabeAuflösung := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => SystemDatentypenHTSEB.EigenesPositive (GrafikKonstanten.MinimaleAuflösungshöhe),
                                                                   ZahlenMaximumExtern => SystemDatentypenHTSEB.EigenesPositive (GrafikKonstanten.MaximaleAuflösungshöhe),
                                                                   WelcheFrageExtern   => TextnummernKonstanten.FrageAuflösungshöhe);
      end case;
      
      case
        EingabeAuflösung.ErfolgreichAbbruch
      is
         when False =>
            return False;
            
         when True =>
            NeueAuflösung.y := Sf.sfUint32 (EingabeAuflösung.EingegebeneZahl);
      
            SchreibeEinstellungenGrafik.Auflösung (AuflösungExtern => NeueAuflösung);
      
            SchreibeLogiktask.WartenGrafik (ZustandExtern => True);
            SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Auflösung_Verändert_Enum);
      end case;
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while LeseLogiktask.WartenGrafik = True loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
      
      return True;
            
   end AuflösungÄndern;
   
   
   
   function BildrateÄndern
     return Boolean
   is
      use type GrafikDatentypen.Fenster_Anpassen_Enum;
   begin
      
      EingabeBildrate := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => SystemDatentypenHTSEB.EigenesNatural (GrafikKonstanten.MinimaleBildrate),
                                                           ZahlenMaximumExtern => SystemDatentypenHTSEB.EigenesPositive (GrafikKonstanten.MaximaleBildrate),
                                                           WelcheFrageExtern   => TextnummernKonstanten.FrageBildrate);
      
      case
        EingabeBildrate.ErfolgreichAbbruch
      is
         when False =>
            return False;
            
         when True =>
            SchreibeEinstellungenGrafik.Bildrate (BildrateExtern => Sf.sfUint32 (EingabeBildrate.EingegebeneZahl));
            SchreibeEinstellungenGrafik.VSync (AktivierenDeaktivierenExtern => Sf.sfFalse);
            SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Bildrate_Ändern_Enum);
      end case;
      
      NeueBildrateAbwartenSchleife:
      while LeseGrafiktask.FensterAnpassen = GrafikDatentypen.Bildrate_Ändern_Enum loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop NeueBildrateAbwartenSchleife;
      
      return True;
      
   end BildrateÄndern;
   
   
   
   procedure VollbildFenster
   is begin
      
      case
        LeseEinstellungenGrafik.Fenstermodus
      is
         when GrafikKonstanten.Vollbild =>
            SchreibeEinstellungenGrafik.Fenstermodus (FenstermodusExtern => GrafikKonstanten.StandardFenster);
            
         when others =>
            SchreibeEinstellungenGrafik.Fenstermodus (FenstermodusExtern => GrafikKonstanten.Vollbild);
      end case;
      
      Fenstermodus;
      
   end VollbildFenster;
   
   
   
   procedure FensterRahmenlos
   is begin
      
      case
        LeseEinstellungenGrafik.Fenstermodus
      is
         when GrafikKonstanten.RahmenlosesFenster =>
            SchreibeEinstellungenGrafik.Fenstermodus (FenstermodusExtern => GrafikKonstanten.StandardFenster);
            
         when others =>
            SchreibeEinstellungenGrafik.Fenstermodus (FenstermodusExtern => GrafikKonstanten.RahmenlosesFenster);
      end case;
      
      Fenstermodus;
      
   end FensterRahmenlos;
   
   
   
   procedure Fenstermodus
   is
      use type GrafikDatentypen.Fenster_Anpassen_Enum;
   begin
      
      SchreibeGrafiktask.FensterAnpassen (AnpassungExtern => GrafikDatentypen.Modus_Verändert_Enum);
      
      ErzeugungNeuesFensterAbwartenSchleife:
      while LeseGrafiktask.FensterAnpassen = GrafikDatentypen.Modus_Verändert_Enum loop
         
         delay ZeitKonstanten.WartezeitLogik;
         
      end loop ErzeugungNeuesFensterAbwartenSchleife;
      
   end Fenstermodus;
   
   
   
   function TexturenWechseln
     return Boolean
   is begin
      
      case
        EinlesenSetsLogik.EinlesenSets (OrdnerExtern => VerzeichnisKonstanten.GrafikOhneStrich)
      is
         when True =>
            GewählteTexturen := SetauswahlLogik.Setauswahl (SpracheExtern => False);
            
            if
              GewählteTexturen = TextKonstantenHTSEB.LeerUnboundedString
            then
               null;
               
            else
               -- Das hier als Funktion aufrufen um bei Fehlern nicht den falschen Wert zu schreiben? äöü
               SchreibeOptionen.Texturen (TexturenExtern => GewählteTexturen);
               EinlesenTexturenLogik.EinlesenTexturen;
               return True;
            end if;
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenGrafikLogik.TexturenWechseln: Texturen nicht gefunden.");
      end case;
      
      return False;
        
   end TexturenWechseln;

end OptionenGrafikLogik;
