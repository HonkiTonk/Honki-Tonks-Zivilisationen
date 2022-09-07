pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;

with EinfachmenueGrafik;
with SteuerungsmenueGrafik;
with AllgemeineViewsGrafik;
with DoppelmenueGrafik;

-- Hier bekommt man bestimmt auch noch irgendwie die Auswahl für die Bau- und Forschungsmenü rein. äöü
-- Entsprechende Umwandlungen in den beiden Menüs auch noch anpassen und die Mehrfachauswahl so aus dem NachGrafiktask rausbekommen. äöü
package body MenueaufteilungGrafik is

   procedure Menüaufteilung
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AktuelleAuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord)
   is begin
      
      AllgemeineViewsGrafik.ÜberschriftErmitteln (WelchesMenüExtern => WelchesMenüExtern);
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Menü_Einfach_Enum'Range =>
            EinfachmenueGrafik.Einfachmenü (WelchesMenüExtern     => WelchesMenüExtern,
                                             AktuelleAuswahlExtern => AktuelleAuswahlExtern.AuswahlEins);
            
         when MenueDatentypen.Menü_Doppelt_Enum =>
            DoppelmenueGrafik.Doppelmenü (WelchesMenüExtern     => WelchesMenüExtern,
                                           AktuelleAuswahlExtern => AktuelleAuswahlExtern.AuswahlEins);
            
         when MenueDatentypen.Steuerung_Menü_Enum =>
            SteuerungsmenueGrafik.Steuerungsmenü (AuswahlExtern => AktuelleAuswahlExtern);
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
