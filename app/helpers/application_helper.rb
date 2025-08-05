module ApplicationHelper
  def icons(icon)
    icons_svg = {
      'straight' => '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" id="Arrows-Horizontal-Bold--Streamline-Phosphor" height="24" width="24">
  <path d="m22.5459375 12.7959375 -3 3a1.125 1.125 0 0 1 -1.59375 -1.59375L19.03125 13.125H4.96875l1.08 1.0790625a1.125 1.125 0 0 1 -1.59375 1.59375l-3 -3a1.125 1.125 0 0 1 0 -1.59375l3 -3a1.125 1.125 0 1 1 1.59375 1.59375L4.96875 10.875h14.0625l-1.08 -1.0790625a1.125 1.125 0 0 1 1.59375 -1.59375l3 3a1.125 1.125 0 0 1 0.0009375 1.59375Z" stroke-width="1"/>
</svg>',
      'plane' => '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" id="Plane-Inflight--Streamline-Tabler" height="24" width="24">
  <path d="M15 11.085h5a2 2 0 1 1 0 4H5l-3 -6h3l2 2h3l-2 -7h3l4 7z" stroke-width="2"/>
  <path d="M3 21h18" stroke-width="2"/>
</svg>',
      'car' => '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" id="Car--Streamline-Lucide" height="24" width="24">
  <path d="M19 17h2c0.6 0 1 -0.4 1 -1v-3c0 -0.9 -0.7 -1.7 -1.5 -1.9C18.7 10.6 16 10 16 10s-1.3 -1.4 -2.2 -2.3c-0.5 -0.4 -1.1 -0.7 -1.8 -0.7H5c-0.6 0 -1.1 0.4 -1.4 0.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 0.6 0.4 1 1 1h2" stroke-width="2"/>
  <path d="M5 17a2 2 0 1 0 4 0 2 2 0 1 0 -4 0" stroke-width="2"/>
  <path d="M9 17h6" stroke-width="2">/</path>
  <path d="M15 17a2 2 0 1 0 4 0 2 2 0 1 0 -4 0" stroke-width="2"/>
</svg>',
      'delete' => '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" id="Delete-2-Line--Streamline-Mingcute" height="24" width="24">
  <g fill="none" fill-rule="nonzero">
    <path d="M24 0v24H0V0h24ZM12.593 23.258l-0.011 0.002 -0.071 0.035 -0.02 0.004 -0.014 -0.004 -0.071 -0.035c-0.01 -0.004 -0.019 -0.001 -0.024 0.005l-0.004 0.01 -0.017 0.428 0.005 0.02 0.01 0.013 0.104 0.074 0.015 0.004 0.012 -0.004 0.104 -0.074 0.012 -0.016 0.004 -0.017 -0.017 -0.427c-0.002 -0.01 -0.009 -0.017 -0.017 -0.018Zm0.265 -0.113 -0.013 0.002 -0.185 0.093 -0.01 0.01 -0.003 0.011 0.018 0.43 0.005 0.012 0.008 0.007 0.201 0.093c0.012 0.004 0.023 0 0.029 -0.008l0.004 -0.014 -0.034 -0.614c-0.003 -0.012 -0.01 -0.02 -0.02 -0.022Zm-0.715 0.002a0.023 0.023 0 0 0 -0.027 0.006l-0.006 0.014 -0.034 0.614c0 0.012 0.007 0.02 0.017 0.024l0.015 -0.002 0.201 -0.093 0.01 -0.008 0.004 -0.011 0.017 -0.43 -0.003 -0.012 -0.01 -0.01 -0.184 -0.092Z" stroke-width="1"/>
    <path fill="currentColor" d="M14.28 2a2 2 0 0 1 1.897 1.368L16.72 5H20a1 1 0 1 1 0 2l-0.003 0.071 -0.867 12.143A3 3 0 0 1 16.138 22H7.862a3 3 0 0 1 -2.992 -2.786L4.003 7.07A1.01 1.01 0 0 1 4 7a1 1 0 0 1 0 -2h3.28l0.543 -1.632A2 2 0 0 1 9.721 2h4.558Zm3.717 5H6.003l0.862 12.071a1 1 0 0 0 0.997 0.929h8.276a1 1 0 0 0 0.997 -0.929L17.997 7ZM10 10a1 1 0 0 1 0.993 0.883L11 11v5a1 1 0 0 1 -1.993 0.117L9 16v-5a1 1 0 0 1 1 -1Zm4 0a1 1 0 0 1 1 1v5a1 1 0 1 1 -2 0v-5a1 1 0 0 1 1 -1Zm0.28 -6H9.72l-0.333 1h5.226l-0.334 -1Z" stroke-width="1"/>
  </g>
</svg>'
    }
    icons_svg[icon]
  end
end
