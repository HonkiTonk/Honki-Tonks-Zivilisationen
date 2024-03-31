with GrafikDatentypen;
with SpielstandVariablen;

with EinfachmenueGrafik;
with SteuerungsmenueGrafik;
with AllgemeineViewsGrafik;
with DoppelmenueGrafik;
with SpielstandmenueGrafik;

with LeseGrafiktask;

package body MenueaufteilungGrafik is

   procedure Menüaufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AktuelleAuswahlExtern : in SystemRecords.MehrfachauswahlRecord)
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Spielstand_Menü_Enum =>
            null;
            
         when others =>
            AllgemeineViewsGrafik.ÜberschriftErmitteln (WelchesMenüExtern => WelchesMenüExtern,
                                                        ZeileExtern       => 1);
      end case;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Einfach_Enum'Range =>
            EinfachmenueGrafik.Einfachmenü (WelchesMenüExtern     => WelchesMenüExtern,
                                             AktuelleAuswahlExtern => AktuelleAuswahlExtern.Erstauswahl);
            
         when MenueDatentypen.Menü_Doppelt_Enum =>
            DoppelmenueGrafik.Doppelmenü (WelchesMenüExtern     => WelchesMenüExtern,
                                           AktuelleAuswahlExtern => AktuelleAuswahlExtern.Erstauswahl);
            
         when MenueDatentypen.Steuerung_Menü_Enum =>
            SteuerungsmenueGrafik.Steuerungsmenü (AuswahlExtern => AktuelleAuswahlExtern.Erstauswahl);
            
         when MenueDatentypen.Spielstand_Menü_Enum =>
            SpielstandmenueGrafik.Spielstandmenü (AuswahlExtern        => AktuelleAuswahlExtern,
                                                   SpielstandartExtern  => SpielstandVariablen.SpielstandartLesen,
                                                   SpeichernLadenExtern => LeseGrafiktask.SpeichernLaden);
      end case;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Haupt_Menü_Enum =>
            AllgemeineViewsGrafik.Versionsnummer (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum);
            
         when others =>
            null;
      end case;
      
   end Menüaufteilung;

end MenueaufteilungGrafik;
