with ZufallsgeneratorenHTSEB;

with Basisgrundplatzierungssystem;

package body KartengeneratorErdweltLogik is

   -- Noch so erweitern dass auf die Oberwelt Rücksicht genommen wird, wenn sie existiert? äöü
   procedure KartengeneratorErdwelt
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      -- Könnte man sowas in eine Funktion Auslagern und dann entsprechend aufrufen? äöü
      -- Anfang
      GezogeneZahl := ZufallsgeneratorenHTSEB.Hunderterbereich;
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in Grundwahrscheinlichkeiten'Range loop
         
         if
           GezogeneZahl in Grundwahrscheinlichkeiten (BasisgrundSchleifenwert).Anfangswahrscheinlichkeit .. Grundwahrscheinlichkeiten (BasisgrundSchleifenwert).Endwahrscheinlichkeit
         then
            WelcherGrund := BasisgrundSchleifenwert;
            exit BasisgrundSchleife;
            
         else
            null;
         end if;
         
      end loop BasisgrundSchleife;
      -- Ende
         
      Basisgrund := Basisgrundumwandlung (WelcherGrund);
      
      Basisgrundplatzierungssystem.Basisgrundplatzierung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                          BasisgrundExtern  => Basisgrund);
      
   end KartengeneratorErdwelt;

end KartengeneratorErdweltLogik;
